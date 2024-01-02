import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width, size.height);
    final radius = size.width / 2;

    final center1 = Offset(size.width / 2, size.height / 4);
    final radius1 = size.width / 4;

    final center2 = Offset(size.width / 7, size.height / 2);
    final radius2 = size.width / 6;

    canvas.drawCircle(const Offset(0, 0), size.width / 1.2, makePaint(const Color.fromARGB(255, 84, 82, 81)));
    canvas.drawCircle(center, radius, makePaint(const Color.fromARGB(255, 240, 81, 70)));
    canvas.drawCircle(center1, radius1, makePaint(const Color.fromARGB(255, 75, 158, 226)));
    canvas.drawCircle(center2, radius2, makePaint(const Color.fromARGB(255, 68, 79, 231)));
    canvas.drawCircle(
        Offset(size.width, size.height / 4), size.width / 6, makePaint(const Color.fromARGB(255, 190, 242, 95)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Paint makePaint(Color color) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }
}
