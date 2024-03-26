import 'package:flutter/material.dart';
import 'dart:math' as math;

class WinLossDrawCircularGraph extends StatelessWidget {
  final int winCount;
  final int drawCount;
  final int lossCount;
  final double radius;
  final String graphName;

  const WinLossDrawCircularGraph({
    Key? key,
    required this.winCount,
    required this.drawCount,
    required this.lossCount,
    required this.radius,
    required this.graphName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = winCount + drawCount + lossCount;
    final winPercentage = winCount / total;
    final drawPercentage = drawCount / total;
    final lossPercentage = lossCount / total;

    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: CircularGraphPainter(
        winPercentage: winPercentage,
        drawPercentage: drawPercentage,
        lossPercentage: lossPercentage,
        graphName: graphName,
      ),
    );
  }
}

class CircularGraphPainter extends CustomPainter {
  final double winPercentage;
  final double drawPercentage;
  final double lossPercentage;
  final String graphName;

  CircularGraphPainter({
    required this.winPercentage,
    required this.drawPercentage,
    required this.lossPercentage,
    required this.graphName,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 10;
    final Offset center = size.center(Offset.zero);
    final double arcAngle = 2 * math.pi;

    final Paint winPaint = _createPaint(Colors.red, strokeWidth);
    final Paint drawPaint = _createPaint(Colors.green, strokeWidth);
    final Paint lossPaint = _createPaint(Colors.blue, strokeWidth);

    // Draw win section
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      -math.pi / 2,
      arcAngle * winPercentage,
      false,
      winPaint,
    );

    // Draw draw section
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      -math.pi / 2 + arcAngle * winPercentage,
      arcAngle * drawPercentage,
      false,
      drawPaint,
    );

    // Draw loss section
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      -math.pi / 2 + arcAngle * (winPercentage + drawPercentage),
      arcAngle * lossPercentage,
      false,
      lossPaint,
    );

    // Draw graph name
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
    final textPainter = TextPainter(
      text: TextSpan(
        text: graphName,
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final xOffset = center.dx - textPainter.width / 2;
    final yOffset = center.dy - size.width / 2 - textPainter.height - 8;
    textPainter.paint(canvas, Offset(xOffset, yOffset));
  }

  Paint _createPaint(Color color, double strokeWidth) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
