import 'package:flutter/material.dart';

class TopBorderCircle extends StatelessWidget {
  final Color color;
  final double radius;
  final double borderWidth;

  const TopBorderCircle({
    Key? key,
    required this.color,
    required this.radius,
    this.borderWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(radius * 2, radius * 2),
      painter: _TopBorderCirclePainter(
        color: color,
        radius: radius,
        borderWidth: borderWidth,
      ),
    );
  }
}

class _TopBorderCirclePainter extends CustomPainter {
  final Color color;
  final double radius;
  final double borderWidth;

  _TopBorderCirclePainter({
    required this.color,
    required this.radius,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius - borderWidth / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
