import 'package:flutter/material.dart';

/// 在指定位置弹出的选项选择器
///
/// - 宽度 [width]，默认 100
/// - 高度 min(40 * 项数, maxHeight)，默认 maxHeight 120
/// - 点击遮罩或选项后关闭
///
/// 使用示例：
/// ```dart
/// showPositionedSelector(
///   context: context,
///   anchor: Offset(100, 200),  // 弹出位置
///   items: ['男', '女'],
///   onSelected: (value) => print('选中: $value'),
/// );
/// ```
void showPositionedSelector<T>({
  required BuildContext context,
  required Offset anchor,
  required List<T> items,
  required ValueChanged<T> onSelected,
  double width = 100,
  double itemHeight = 40,
  double maxHeight = 120,
  String Function(T)? itemBuilder,
}) {
  final overlay = Overlay.of(context);
  final itemCount = items.length;
  final contentHeight = (itemHeight * itemCount).clamp(0.0, maxHeight).toDouble();

  OverlayEntry? overlayEntry;

  void dismiss([T? selected]) {
    overlayEntry?.remove();
    overlayEntry = null;
    if (selected != null) {
      onSelected(selected);
    }
  }

  overlayEntry = OverlayEntry(
    builder: (ctx) {
      final screenSize = MediaQuery.of(ctx).size;
      double left = anchor.dx;
      double top = anchor.dy;

      // 边界检测：避免超出屏幕
      if (left + width > screenSize.width) {
        left = screenSize.width - width - 8;
      }
      if (left < 8) left = 8;
      if (top + contentHeight > screenSize.height - 8) {
        top = screenSize.height - contentHeight - 8;
      }
      if (top < 8) top = 8;

      return Stack(
        children: [
          // 透明遮罩，点击关闭
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => dismiss(),
            ),
          ),
          // 选项框
          Positioned(
            left: left,
            top: top,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: width,
                height: contentHeight,
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(ctx).dividerColor,
                    width: 0.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: itemCount,
                    itemBuilder: (_, i) {
                      final item = items[i];
                      final label = itemBuilder?.call(item) ?? item.toString();
                      return InkWell(
                        onTap: () => dismiss(item),
                        child: SizedBox(
                          height: itemHeight,
                          child: Center(
                            child: Text(
                              label,
                              style: Theme.of(ctx).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );

  overlay.insert(overlayEntry!);
}
