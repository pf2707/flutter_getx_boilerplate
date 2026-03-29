
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedScaleTextWidget extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Function? onAnimationComplete;
  const AnimatedScaleTextWidget({super.key, required this.text, this.textStyle, this.onAnimationComplete});

  @override
  State<AnimatedScaleTextWidget> createState() => _AnimatedScaleTextWidgetState();
}

class _AnimatedScaleTextWidgetState extends State<AnimatedScaleTextWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController with a duration of 800ms for snappy effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Scale animation with accelerating curve
    _scaleAnimation = Tween<double>(begin: 0.5, end: 8.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInExpo, // Accelerates exponentially
      ),
    );

    // Opacity animation for fade-in
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Add status listener to detect animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Callback when animation completes
        if (widget.onAnimationComplete != null) {
          widget.onAnimationComplete!();
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

  void _startAnimation() {
    _controller.reset(); // Reset to start
    _controller.forward(); // Play animation
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnimation, // Trigger animation on tap
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Text(
            widget.text,
            style: widget.textStyle ?? CommonUtils.fontPoppinsW700(10.sp, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}