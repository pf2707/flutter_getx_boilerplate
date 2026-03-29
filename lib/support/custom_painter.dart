
import 'package:flutter/material.dart';
// import 'package:flutter_getx_boilerplate/constant/constant.dart';

class GridPainter extends CustomPainter {
  final int columns;
  final double dashLength;
  final double dashGap;

  GridPainter({
    this.columns = 8,
    this.dashLength = 8,
    this.dashGap = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha(40)
      ..strokeWidth = 1;

    final cellSize = size.width / columns;
    final rows = (size.height / cellSize).floor();
    final gridHeight = cellSize * rows;

    // Draw horizontal dashed lines
    for (int i = 0; i <= rows; i++) {
      double y = i * cellSize;
      double startX = 0;
      while (startX < size.width) {
        double endX = (startX + dashLength).clamp(0, size.width);
        canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
        startX += dashLength + dashGap;
      }
    }

    // Draw vertical dashed lines
    for (int i = 0; i <= columns; i++) {
      double x = i * cellSize;
      double startY = 0;
      while (startY < gridHeight) {
        double endY = (startY + dashLength).clamp(0, gridHeight);
        canvas.drawLine(Offset(x, startY), Offset(x, endY), paint);
        startY += dashLength + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// class InjectMemoryCustomPaint extends CustomPainter {
//
//   Size painterSize;
//   InjectMemoryCustomPaint(this.painterSize);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.fill
//       ..color = EnumMemoryAccessType.inject.representativeColor();
//
//     var firstHeight = 100.0;
//     var halfSecondHeight = (size.height - firstHeight) / 2;
//     Path path = Path()
//       ..moveTo(0, 0)
//       ..lineTo(size.width - 40, 0)
//
//       ..cubicTo(size.width - 40, 0, size.width - 30, firstHeight / 2, size.width - 40, firstHeight)
//       ..cubicTo(size.width - 40, firstHeight + 10, size.width - 40 - 80, firstHeight + halfSecondHeight / 2, size.width - 40, firstHeight + halfSecondHeight)
//
//       ..cubicTo(size.width - 40, firstHeight + halfSecondHeight, size.width + 80, firstHeight + halfSecondHeight + halfSecondHeight / 2, size.width - 40, size.height)
//     // ..lineTo(size.width - 40, size.height)
//
//       ..lineTo(0, size.height)
//       ..lineTo(0, 0)
//       ..close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
//
// class ExtractMemoryCustomPaint extends CustomPainter {
//
//   Size painterSize;
//   ExtractMemoryCustomPaint(this.painterSize);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.fill
//       ..color = EnumMemoryAccessType.extract.representativeColor();
//
//     var firstHeight = 100.0;
//     var halfSecondHeight = (size.height - firstHeight) / 2;
//     Path path = Path()
//       ..moveTo(0, 0)
//       ..lineTo(size.width, 0)
//
//       ..lineTo(size.width, size.height)
//       ..lineTo(0, size.height)
//
//       ..cubicTo(0, size.height, 80, firstHeight + halfSecondHeight + halfSecondHeight / 2, 0, firstHeight + halfSecondHeight)
//       ..cubicTo(0, firstHeight + halfSecondHeight, -80, firstHeight + halfSecondHeight / 2, 0, firstHeight)
//
//       ..cubicTo(0, firstHeight, 10, firstHeight / 2, 0, 0)
//       ..close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }