import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_stateful_page.dart';
import 'package:my_app/widgets/positioned_selector.dart';

/// 自定义位置弹出选择器 Demo
/// 在点击位置弹出选项框：宽 100，高 min(40×项数, 120)，点击空白或选项后关闭
class PositionedSelectorDemoPage extends MyBaseStatefulPage {
  const PositionedSelectorDemoPage({super.key});

  @override
  State<PositionedSelectorDemoPage> createState() =>
      _PositionedSelectorDemoPageState();

  @override
  String get pageTitle => '自定义弹出框';
}

class _PositionedSelectorDemoPageState
    extends MyBaseStatefulPageState<PositionedSelectorDemoPage> {
  String? _selectedGender;
  String? _selectedFruit;

  void _showGenderSelector(TapDownDetails details) {
    showPositionedSelector<String>(
      context: context,
      anchor: details.globalPosition,
      items: const ['男', '女'],
      onSelected: (value) {
        setState(() => _selectedGender = value);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('性别选中: $value')),
        );
      },
    );
  }

  void _showFruitSelector(TapDownDetails details) {
    showPositionedSelector<String>(
      context: context,
      anchor: details.globalPosition,
      items: const ['苹果', '香蕉', '橙子'],
      onSelected: (value) {
        setState(() => _selectedFruit = value);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('水果选中: $value')),
        );
      },
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '在下方区域点击，会在点击位置弹出选择器。\n点击空白处或选项可关闭。',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildTriggerCard(
            context,
            title: '性别',
            value: _selectedGender ?? '请点击选择',
            onTapDown: _showGenderSelector,
          ),
          const SizedBox(height: 16),
          _buildTriggerCard(
            context,
            title: '水果',
            value: _selectedFruit ?? '请点击选择',
            onTapDown: _showFruitSelector,
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerCard(
    BuildContext context, {
    required String title,
    required String value,
    required void Function(TapDownDetails) onTapDown,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTapDown: onTapDown,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        color: value.startsWith('请')
                            ? Colors.grey
                            : Colors.black87,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
