import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/app_style_manager.dart';

/// 全局风格切换悬浮按钮
/// 支持双击切换风格
class GlobalStyleToggleButton extends StatefulWidget {
  const GlobalStyleToggleButton({super.key});

  @override
  State<GlobalStyleToggleButton> createState() =>
      _GlobalStyleToggleButtonState();
}

class _GlobalStyleToggleButtonState extends State<GlobalStyleToggleButton> {
  DateTime? _lastTapTime;
  static const Duration _doubleTapDelay = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final styleNotifier = AppStyleManager.of(context);

    return ListenableBuilder(
      listenable: styleNotifier,
      builder: (context, _) {
        final isMaterial =
            styleNotifier.currentStyle == AppDesignStyle.material;

        return Positioned(
          right: 16,
          bottom: 80, // 留出空间，避免与其他 FAB 重叠
          child: GestureDetector(
            onTap: () {
              final now = DateTime.now();

              // 检测双击
              if (_lastTapTime != null &&
                  now.difference(_lastTapTime!) < _doubleTapDelay) {
                // 双击：切换风格
                styleNotifier.toggleStyle();
                _lastTapTime = null; // 重置，避免三击误触发
              } else {
                // 单击：记录时间
                _lastTapTime = now;
              }
            },
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isMaterial ? Colors.blue : CupertinoColors.systemBlue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                isMaterial
                    ? Icons.android
                    : CupertinoIcons.device_phone_portrait,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  }
}
