
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedGetReadyWidget extends StatefulWidget {
  final int maxDuration;
  final TextStyle? textStyle;
  final Function? onAnimationComplete;
  const AnimatedGetReadyWidget({super.key, this.maxDuration = 3, this.textStyle, this.onAnimationComplete});

  @override
  State<AnimatedGetReadyWidget> createState() => _AnimatedGetReadyWidgetState();
}

class _AnimatedGetReadyWidgetState extends State<AnimatedGetReadyWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late int _currentDuration;

  @override
  void initState() {
    super.initState();

    _currentDuration = widget.maxDuration;

    // Initialize AnimationController with a duration of 800ms for snappy effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Opacity animation for fade-in
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Add status listener to detect animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Callback when animation completes
        if (_currentDuration > 0) {
          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              _currentDuration--;
            });
            _controller.reset();
            _controller.forward(from: 0);
          });
        } else {
          if (widget.onAnimationComplete != null) {
            widget.onAnimationComplete!();
          }
        }
      }
    });

    // Start animation on init
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _startAnimation() {
  //   _controller.reset(); // Reset to start
  //   _controller.forward(); // Play animation
  // }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Text(
        _currentDuration.toString(),
        style: widget.textStyle ?? CommonUtils.fontPoppinsW700(10.sp, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}