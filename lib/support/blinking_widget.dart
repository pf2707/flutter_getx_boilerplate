import 'package:flutter/material.dart';

class BlinkingWidget extends StatefulWidget {
  final Widget child;
  final double beginOpacity;
  final double endOpacity;
  final Duration duration; // total time for one full cycle (1→0→1)

  const BlinkingWidget({
    super.key,
    required this.child,
    this.beginOpacity = 1.0,
    this.endOpacity = 0.0,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<BlinkingWidget> createState() => _BlinkingWidgetState();
}

class _BlinkingWidgetState extends State<BlinkingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true); // This is the magic line!

    // Tween from 1.0 → 0.0 → 1.0 → 0.0 forever
    _animation = Tween<double>(begin: widget.beginOpacity, end: widget.endOpacity).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );

    // Or use AnimatedOpacity if you prefer (same result):
    // return AnimatedOpacity(
    //   opacity: _animation.value,
    //   duration: widget.duration,
    //   child: widget.child,
    // );
  }
}