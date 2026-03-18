import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_page.dart';
import 'package:my_app/widgets/svg_color_hit_test_demo.dart';
import 'package:my_app/widgets/svg_demo_section.dart';

class SvgDemoPage extends MyBasePage {
  const SvgDemoPage({super.key});

  static const String tangramAssetPath = 'assets/svg/tangram_test.svg';

  @override
  String get pageTitle => 'SVG Hit Test';

  @override
  Color get appBarBackgroundColor => const Color(0xFF9FD0FF);

  @override
  Color? get pageBackgroundColor => const Color(0xFFF4F9FF);

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _SvgDemoIntroCard(),
        SvgDemoSection(
          title: '点击实验',
          description:
              '点击下方七巧板图形后，页面会返回命中的色块名称、该色块在 SVG 里定义的原始颜色值，以及转换后的 SVG 坐标。',
          child: SvgColorHitTestDemo(assetPath: tangramAssetPath),
        ),
        SvgDemoSection(
          title: '实现思路',
          description:
              '这个 demo 不是屏幕取色器，而是先把点击位置换算到 SVG viewBox，再用与 SVG 同步的几何路径做命中测试，最后返回被命中色块的源 fill 颜色。',
          child: _SvgDemoNotes(),
        ),
      ],
    );
  }
}

class _SvgDemoIntroCard extends StatelessWidget {
  const _SvgDemoIntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB8DCFF), Color(0xFFEAF5FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        '这里用一个七巧板风格的测试 SVG 来验证“点击后拿到 SVG 自身这个点所属色块的原始颜色”这件事。',
        style: TextStyle(
          fontSize: 15,
          height: 1.6,
          fontWeight: FontWeight.w500,
          color: Color(0xFF16324F),
        ),
      ),
    );
  }
}

class _SvgDemoNotes extends StatelessWidget {
  const _SvgDemoNotes();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('1. 当前测试文件里的每个拼块都是单独的纯色 polygon。'),
        SizedBox(height: 8),
        Text('2. 点击时先把屏幕位置映射到 100 x 100 的 SVG 坐标系。'),
        SizedBox(height: 8),
        Text('3. 再逐块判断 Path.contains，命中后返回该块的 fill 颜色。'),
        SizedBox(height: 8),
        Text('4. 这种方式适合纯色块 SVG；如果后面有渐变、透明叠加或滤镜，需要再升级命中逻辑。'),
      ],
    );
  }
}
