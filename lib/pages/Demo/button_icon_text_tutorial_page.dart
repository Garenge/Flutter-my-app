import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/base/my_base_page.dart';
import 'package:my_app/widgets/unified_buttons.dart';

/// 按钮图标 + 文字布局教程页面
///
/// 在 iOS 原生（UIKit）里，如果一个按钮既要有图标又要有文字，
/// 想要实现「文字在左、图标在右」或更复杂的布局，往往需要通过：
/// - 调整 `contentEdgeInsets`
/// - 调整 `titleEdgeInsets`
/// - 调整 `imageEdgeInsets`
/// - 甚至自定义 `UIButton` 子类、重写 `layoutSubviews` 等
///
/// 在 Flutter 中，按钮的「图标 + 文字」本质上只是一个可以随意排版的 `child`，
/// 因此我们可以直接用 `Row` / `Column` / `Wrap` 等布局组件，非常灵活。
class ButtonIconTextTutorialPage extends MyBasePage {
  const ButtonIconTextTutorialPage({super.key});

  @override
  String get pageTitle => '按钮图标与文字教程';

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('1. 基本概念：按钮的 child 可以随便排版'),
        const SizedBox(height: 8),
        const Text(
          '在 Flutter 里，大部分按钮（如 ElevatedButton、TextButton、CupertinoButton 等）'
          '都接收一个 `child` 参数，类型是 Widget。\n\n'
          '这意味着：\n'
          '- 你可以传入一个 `Text`，只有文字的按钮；\n'
          '- 也可以传入一个 `Icon`，只有图标的按钮；\n'
          '- 更常见的是传入一个 `Row`，里面同时放 `Icon` 和 `Text`，随意控制顺序和间距。',
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('2. 文字在左，图标在右（最常见的定制需求）'),
        const SizedBox(height: 8),
        const Text(
          '在 iOS UIKit 里，这种需求需要调整多种 inset，比较繁琐。\n'
          '在 Flutter 中，只需要把按钮的 child 写成一个 Row，并且让 Text 在前、Icon 在后即可：',
        ),
        const SizedBox(height: 12),
        Center(
          child: UnifiedButton(
            filled: true,
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min, // 让 Row 根据内容收缩，而不是占满整行
              children: const [
                Text('提交'),
                SizedBox(width: 8),
                Icon(Icons.send),
              ],
            ),
            materialConfig: {
              'style': ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            },
            cupertinoConfig: {
              'padding':
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            },
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '关键点：\n'
          '- 使用 `Row` 控制子组件的顺序，谁写在前谁就在左边；\n'
          '- 通过 `SizedBox(width: 8)` 控制图标和文字的间距；\n'
          '- 使用 `mainAxisSize: MainAxisSize.min`，让按钮宽度根据内容自适应，而不是铺满整行。',
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('3. 图标在左，文字在右（传统布局）'),
        const SizedBox(height: 8),
        const Text(
          '只需要把 Row 里 Icon 和 Text 的顺序对调即可：',
        ),
        const SizedBox(height: 12),
        Center(
          child: UnifiedButton(
            filled: true,
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.download),
                SizedBox(width: 8),
                Text('下载'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('4. 文字在上，图标在下 / 垂直排版'),
        const SizedBox(height: 8),
        const Text(
          '如果希望文字在上、图标在下，只需要把 child 换成 Column 即可：',
        ),
        const SizedBox(height: 12),
        Center(
          child: UnifiedButton(
            filled: false,
            onPressed: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('相册'),
                SizedBox(height: 4),
                Icon(Icons.photo),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('5. iOS 中复杂的 inset，在 Flutter 里换成布局思维'),
        const SizedBox(height: 8),
        const Text(
          '在 iOS UIKit 中，你可能会这样写：\n'
          '- 调整 UIButton 的 imageEdgeInsets / titleEdgeInsets\n'
          '- 控制 contentHorizontalAlignment\n'
          '- 甚至重写 layoutSubviews\n\n'
          '而在 Flutter 中，我们建议完全不要去「微调 inset」，而是：\n'
          '- 把按钮的 child 当成一个「小布局」；\n'
          '- 用 Row / Column / Wrap 组合姿势；\n'
          '- 用 SizedBox 设置间距，用 Spacer 做弹性空白。\n\n'
          '这样一来，按钮图标和文字的布局就和普通布局代码完全一致，\n'
          '不需要记住各种 inset 的方向和正负号，也更直观、可维护。',
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('6. 总结：Flutter 如何优雅解决按钮图标 + 文字问题'),
        const SizedBox(height: 8),
        const Text(
          '1）按钮只负责「壳」和点击效果，内容交给 child 自己排版；\n'
          '2）想要「文左图右」就用 Row(Text, Icon)，想要「图左文右」就 Row(Icon, Text)；\n'
          '3）用 SizedBox 控制间距，用 mainAxisSize 控制占用空间；\n'
          '4）从「调 inset」这个思路，转变为「写一个小布局」的思路，会简单很多。',
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

