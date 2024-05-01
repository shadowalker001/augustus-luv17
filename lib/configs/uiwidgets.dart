import 'package:flutter/material.dart';
import 'package:luvit/configs/size_config.dart';
import 'package:luvit/configs/theme.dart';

class UiWidgets {
  static double widthMultiplier = SizeConfig.widthMultiplier;
  static double textMultiplier = SizeConfig.textMultiplier;

  static Widget textItem(String title,
      {double mul = 1,
      bool isBold = false,
      Color color = Colors.white,
      bool visible = false}) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: textMultiplier * mul,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        overflow: visible ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
    );
  }

  static Widget shadedGradient() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: CustomTheme.gradient,
            ).createShader(bounds);
          },
          child: Icon(
            Icons.favorite,
            color: CustomTheme.gradient[0],
          ),
        ),
      ),
    );
  }

  static Widget favorite() {
    return Stack(
      children: [
        SizedBox(
          width: widthMultiplier * 11,
          height: widthMultiplier * 11,
          child: UiWidgets.shadedGradient(),
        ),
        SizedBox(
          width: widthMultiplier * 11,
          height: widthMultiplier * 11,
          child: CustomPaint(
            painter: GradientBorderPainter(
              strokeWidth: 2.0,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: CustomTheme.gradient,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget boxedItem(
    String text, {
    Widget? icon,
    required double width,
    required double height,
    double mul = 2.8,
    BoxBorder? border,
    Color boxColor = Colors.black,
    Color textColor = Colors.white,
    double? buttonTextWdth,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(widthMultiplier * 6),
        border: border,
      ),
      width: width,
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthMultiplier * 2.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            Visibility(
              visible: icon != null,
              child: const SizedBox(width: 5),
            ),
            Container(
              // color: Colors.red,
              // width: icon == null
              //     ? width - (widthMultiplier * 7.5)
              //     : width - (widthMultiplier * 10),
              width: buttonTextWdth,
              child: Text(
                text,
                textAlign: icon != null ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: textMultiplier * mul,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Gradient gradient;

  GradientBorderPainter({required this.strokeWidth, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2,
        ),
      )
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double halfStrokeWidth = strokeWidth / 2;
    final double radius = size.width / 2;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    canvas.drawCircle(
      Offset(centerX, centerY),
      radius - halfStrokeWidth,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
