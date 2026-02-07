import 'package:flutter/material.dart';

/// Debug 模式下右上角的小三角指示器
class DebugCornerIndicator extends StatelessWidget {
  final Widget child;
  final double size;
  final Color color;

  const DebugCornerIndicator({
    super.key,
    required this.child,
    this.size = 20,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: CustomPaint(
            size: Size(size, size),
            painter: _TrianglePainter(color: color),
          ),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
