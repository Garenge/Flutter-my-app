import 'package:flutter/material.dart';

class SvgTangramPiece {
  final String id;
  final String label;
  final Color color;
  final List<Offset> points;

  const SvgTangramPiece({
    required this.id,
    required this.label,
    required this.color,
    required this.points,
  });

  Path buildPath() {
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    path.close();
    return path;
  }

  String get hexColor {
    final red = (color.r * 255.0).round().clamp(0, 255);
    final green = (color.g * 255.0).round().clamp(0, 255);
    final blue = (color.b * 255.0).round().clamp(0, 255);
    final redHex = red.toRadixString(16).padLeft(2, '0').toUpperCase();
    final greenHex = green.toRadixString(16).padLeft(2, '0').toUpperCase();
    final blueHex = blue.toRadixString(16).padLeft(2, '0').toUpperCase();
    return '#$redHex$greenHex$blueHex';
  }
}

const List<SvgTangramPiece> svgTangramPieces = [
  SvgTangramPiece(
    id: 'left_triangle',
    label: '左下大三角',
    color: Color(0xFFF94144),
    points: [Offset(8, 76), Offset(36, 48), Offset(36, 92)],
  ),
  SvgTangramPiece(
    id: 'center_triangle',
    label: '中部大三角',
    color: Color(0xFFF3722C),
    points: [Offset(36, 48), Offset(64, 20), Offset(64, 64)],
  ),
  SvgTangramPiece(
    id: 'top_triangle',
    label: '右上小三角',
    color: Color(0xFFF8961E),
    points: [Offset(64, 20), Offset(88, 44), Offset(64, 44)],
  ),
  SvgTangramPiece(
    id: 'square',
    label: '右侧正方形',
    color: Color(0xFFF9C74F),
    points: [Offset(64, 44), Offset(88, 44), Offset(88, 68), Offset(64, 68)],
  ),
  SvgTangramPiece(
    id: 'diamond',
    label: '中心菱形',
    color: Color(0xFF90BE6D),
    points: [Offset(50, 64), Offset(64, 50), Offset(78, 64), Offset(64, 78)],
  ),
  SvgTangramPiece(
    id: 'left_parallelogram',
    label: '左侧平行四边形',
    color: Color(0xFF43AA8B),
    points: [Offset(14, 30), Offset(24, 20), Offset(38, 34), Offset(28, 44)],
  ),
  SvgTangramPiece(
    id: 'top_trapezoid',
    label: '顶部梯形',
    color: Color(0xFF577590),
    points: [Offset(32, 8), Offset(54, 8), Offset(62, 20), Offset(24, 20)],
  ),
];
