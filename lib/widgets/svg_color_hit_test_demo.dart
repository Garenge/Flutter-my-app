import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/models/svg_tangram_piece.dart';

class SvgColorHitTestDemo extends StatefulWidget {
  final String assetPath;

  const SvgColorHitTestDemo({
    super.key,
    required this.assetPath,
  });

  @override
  State<SvgColorHitTestDemo> createState() => _SvgColorHitTestDemoState();
}

class _SvgColorHitTestDemoState extends State<SvgColorHitTestDemo> {
  static const double _viewBoxSize = 100;

  SvgTangramPiece? _selectedPiece;
  Offset? _selectedPoint;

  void _handleTap(TapDownDetails details, BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final svgPoint = Offset(
      details.localPosition.dx / width * _viewBoxSize,
      details.localPosition.dy / width * _viewBoxSize,
    );
    final hitPiece = _findPieceAt(svgPoint);

    setState(() {
      _selectedPoint = svgPoint;
      _selectedPiece = hitPiece;
    });
  }

  SvgTangramPiece? _findPieceAt(Offset point) {
    for (final piece in svgTangramPieces.reversed) {
      if (piece.buildPath().contains(point)) {
        return piece;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTapDown: (details) => _handleTap(details, constraints),
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7FAFC),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFD6E2EE)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(widget.assetPath),
                        ),
                      ),
                    ),
                    if (_selectedPoint != null)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: CustomPaint(
                            painter: _SelectionMarkerPainter(
                              point: _selectedPoint!,
                              color: _selectedPiece?.color ?? Colors.black87,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        _buildResultCard(),
        const SizedBox(height: 16),
        _buildLegend(),
      ],
    );
  }

  Widget _buildResultCard() {
    final pointText = _selectedPoint == null
        ? '尚未点击'
        : '(${_selectedPoint!.dx.toStringAsFixed(1)}, ${_selectedPoint!.dy.toStringAsFixed(1)})';

    final description = _selectedPiece == null
        ? '点击七巧板内部的纯色块后，这里会显示命中的 SVG 源颜色。'
        : '命中 ${_selectedPiece!.label}，源颜色为 ${_selectedPiece!.hexColor}。';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD9E5F5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '点击结果',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text('SVG 坐标: $pointText'),
          const SizedBox(height: 6),
          Text('命中色块: ${_selectedPiece?.label ?? '未命中'}'),
          const SizedBox(height: 6),
          Text('颜色值: ${_selectedPiece?.hexColor ?? '无'}'),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF556070),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: svgTangramPieces.map(_buildLegendItem).toList(),
    );
  }

  Widget _buildLegendItem(SvgTangramPiece piece) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD9E5F5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: piece.color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text('${piece.label} ${piece.hexColor}'),
        ],
      ),
    );
  }
}

class _SelectionMarkerPainter extends CustomPainter {
  final Offset point;
  final Color color;

  const _SelectionMarkerPainter({
    required this.point,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dx = point.dx / 100 * size.width;
    final dy = point.dy / 100 * size.width;

    final fillPaint = Paint()..color = Colors.white;
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(dx, dy), 8, fillPaint);
    canvas.drawCircle(Offset(dx, dy), 8, strokePaint);
    canvas.drawCircle(Offset(dx, dy), 2.5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _SelectionMarkerPainter oldDelegate) {
    return oldDelegate.point != point || oldDelegate.color != color;
  }
}
