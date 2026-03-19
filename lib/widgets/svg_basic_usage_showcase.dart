import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgBasicUsageShowcase extends StatelessWidget {
  const SvgBasicUsageShowcase({super.key});

  static const String _badgeAssetPath = 'assets/svg/learning_badge.svg';
  static const String _inlineSvg = '''
<svg viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
  <rect x="8" y="8" width="48" height="48" rx="14" fill="#1F6BFF"/>
  <path d="M22 33l7 7 13-16" stroke="#ffffff" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _UsageCard(
          title: '1. 资源文件直接显示',
          description: '最常见的写法就是 `SvgPicture.asset(...)`，适合 Logo、插画、空状态图。',
          child: _AssetExample(),
        ),
        const SizedBox(height: 12),
        const _UsageCard(
          title: '2. 控制尺寸与适配',
          description: '配合固定容器和 `fit`，可以让 SVG 在卡片、按钮、Banner 中保持合适比例。',
          child: _FitExample(),
        ),
        const SizedBox(height: 12),
        const _UsageCard(
          title: '3. 从字符串构建并统一染色',
          description:
              '后端下发 SVG 文本时可以用 `SvgPicture.string(...)`；单色图标再配合 `colorFilter` 更灵活。',
          child: _StringExample(),
        ),
      ],
    );
  }
}

class _UsageCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;

  const _UsageCard({
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD9E5F5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17324D),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF5B6472),
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _AssetExample extends StatelessWidget {
  const _AssetExample();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PreviewBox(
            label: '原图',
            child: SvgPicture.asset(
              SvgBasicUsageShowcase._badgeAssetPath,
              width: 84,
              height: 84,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _PreviewBox(
            label: '小尺寸',
            child: SvgPicture.asset(
              SvgBasicUsageShowcase._badgeAssetPath,
              width: 48,
              height: 48,
            ),
          ),
        ),
      ],
    );
  }
}

class _FitExample extends StatelessWidget {
  const _FitExample();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PreviewBox(
            label: 'contain',
            child: SizedBox(
              width: 110,
              height: 72,
              child: SvgPicture.asset(
                SvgBasicUsageShowcase._badgeAssetPath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _PreviewBox(
            label: 'cover',
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: SizedBox(
                width: 110,
                height: 72,
                child: SvgPicture.asset(
                  SvgBasicUsageShowcase._badgeAssetPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StringExample extends StatelessWidget {
  const _StringExample();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PreviewBox(
            label: 'SVG 字符串',
            child: SvgPicture.string(
              SvgBasicUsageShowcase._inlineSvg,
              width: 68,
              height: 68,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _PreviewBox(
            label: '统一染色',
            child: SvgPicture.string(
              SvgBasicUsageShowcase._inlineSvg,
              width: 68,
              height: 68,
              colorFilter: ColorFilter.mode(
                Color(0xFF00A86B),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PreviewBox extends StatelessWidget {
  final String label;
  final Widget child;

  const _PreviewBox({
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD9E5F5)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4D637B),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 92,
            child: Center(child: child),
          ),
        ],
      ),
    );
  }
}
