
import 'package:flutter/material.dart';
import 'dart:math' as math;

/// ---------------------------------------------------------------
///  CurvedWord – draws any word along a circular arc with per-letter size
/// ---------------------------------------------------------------
class CurvedWord extends StatelessWidget {
  final String text;
  final double maxFontSize;
  final double minFontSize;
  final double radius;
  final double startAngle; // in radians
  final double sweepAngle; // in radians

  const CurvedWord({
    super.key,
    required this.text,
    this.maxFontSize = 80,
    this.minFontSize = 30,
    this.radius = 180,
    this.startAngle = -math.pi / 2,
    this.sweepAngle = math.pi,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvedWordPainter(
        word: text,
        maxFontSize: maxFontSize,
        minFontSize: minFontSize,
        radius: radius,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
      ),
    );
  }
}

/// ---------------------------------------------------------------
///  The actual painter
/// ---------------------------------------------------------------
class _CurvedWordPainter extends CustomPainter {
  final String word;
  final double maxFontSize;
  final double minFontSize;
  final double radius;
  final double startAngle;
  final double sweepAngle;

  _CurvedWordPainter({
    required this.word,
    required this.maxFontSize,
    required this.minFontSize,
    required this.radius,
    required this.startAngle,
    required this.sweepAngle,
  });

  // -----------------------------------------------------------------
  // 1. Define the size-curve you described (A → big, a/z → small, …)
  // -----------------------------------------------------------------
  double _fontSizeForIndex(int i, int length) {
    // Normalised position 0..1
    final t = i / (length - 1);

    // You can tweak the formula – this one gives:
    //   A (0)   → max
    //   m (≈0.14) → ~0.7*max
    //   a (≈0.29) → min
    //   z (≈0.43) → min
    //   i,n,g   → rise back to max
    const double pA = 0.0;
    const double pM = 0.14;
    const double pA2 = 0.29; // second 'a'
    const double pZ = 0.43;
    const double pEnd = 1.0;

    double size;
    if (t <= pM) {
      // A → m : linear down
      size = maxFontSize - (maxFontSize - minFontSize * 1.4) * (t - pA) / (pM - pA);
    } else if (t <= pA2) {
      // m → a : continue down
      size = minFontSize * 1.4 -
          (minFontSize * 1.4 - minFontSize) * (t - pM) / (pA2 - pM);
    } else if (t <= pZ) {
      // a → z : stay at min
      size = minFontSize;
    } else {
      // z → end : linear up to max
      size = minFontSize +
          (maxFontSize - minFontSize) * (t - pZ) / (pEnd - pZ);
    }
    return size.clamp(minFontSize, maxFontSize);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final letters = word.split('');
    final n = letters.length;

    // Angle step for each letter
    final angleStep = sweepAngle / (n - 1);

    for (int i = 0; i < n; i++) {
      final char = letters[i];
      final fontSize = _fontSizeForIndex(i, n);

      final textPainter = TextPainter(textDirection: TextDirection.ltr);
      final textStyle = TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        // optional: give a little “glow”
        shadows: const [
          Shadow(
            blurRadius: 6,
            color: Colors.cyanAccent,
            offset: Offset(0, 0),
          ),
        ],
      );

      final span = TextSpan(text: char, style: textStyle);
      textPainter.text = span;
      textPainter.layout();

      // -------------------------------------------------------------
      // Position on the arc
      // -------------------------------------------------------------
      final angle = startAngle + i * angleStep;
      final dx = radius * math.cos(angle);
      final dy = radius * math.sin(angle);

      // Center of the arc is at (size.width/2, size.height/2)
      final centerX = size.width / 2;
      final centerY = size.height / 2;

      // Rotate the canvas so the letter faces outward
      canvas.save();
      canvas.translate(centerX + dx, centerY + dy);
      canvas.rotate(angle + math.pi / 2); // +90° to make baseline radial

      // Move the baseline to the outer side of the arc
      final offsetX = -textPainter.width / 2;
      final offsetY = -textPainter.height / 2;
      textPainter.paint(canvas, Offset(offsetX, offsetY));

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}