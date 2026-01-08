import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/app_style_manager.dart';

/// 统一的按钮组件
/// 根据当前风格自动选择合适的按钮样式
class UnifiedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final AppDesignStyle? style; // 可选：强制指定风格
  final Map<String, dynamic>? materialConfig; // Material 特定配置
  final Map<String, dynamic>? cupertinoConfig; // Cupertino 特定配置
  final bool filled; // 是否填充样式（Material 的 ElevatedButton，Cupertino 的 filled）

  const UnifiedButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style,
    this.materialConfig,
    this.cupertinoConfig,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    // 如果没有指定风格，从上下文获取
    final currentStyle = style ??
        (AppStyleManager.maybeOf(context)?.currentStyle ??
            AppDesignStyle.material);

    if (currentStyle == AppDesignStyle.cupertino) {
      if (filled) {
        return CupertinoButton.filled(
          onPressed: onPressed,
          child: child,
          // 支持其他 CupertinoButton.filled 的配置
          padding: cupertinoConfig?['padding'] as EdgeInsets?,
        );
      } else {
        return CupertinoButton(
          onPressed: onPressed,
          child: child,
          // 支持其他 CupertinoButton 的配置
          padding: cupertinoConfig?['padding'] as EdgeInsets?,
        );
      }
    } else {
      if (filled) {
        return ElevatedButton(
          onPressed: onPressed,
          child: child,
          // 支持其他 ElevatedButton 的配置
          style: materialConfig?['style'] as ButtonStyle?,
        );
      } else {
        return TextButton(
          onPressed: onPressed,
          child: child,
          // 支持其他 TextButton 的配置
          style: materialConfig?['style'] as ButtonStyle?,
        );
      }
    }
  }
}

/// 统一的浮动操作按钮组件
/// Material 风格使用 FloatingActionButton，Cupertino 风格使用 CupertinoButton
class UnifiedFloatingActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final AppDesignStyle? style; // 可选：强制指定风格
  final Map<String, dynamic>? materialConfig; // Material 特定配置
  final Map<String, dynamic>? cupertinoConfig; // Cupertino 特定配置

  const UnifiedFloatingActionButton({
    super.key,
    required this.child,
    this.onPressed,
    this.style,
    this.materialConfig,
    this.cupertinoConfig,
  });

  @override
  Widget build(BuildContext context) {
    // 如果没有指定风格，从上下文获取
    final currentStyle = style ??
        (AppStyleManager.maybeOf(context)?.currentStyle ??
            AppDesignStyle.material);

    if (currentStyle == AppDesignStyle.cupertino) {
      return CupertinoButton(
        onPressed: onPressed,
        child: child,
        // 支持其他 CupertinoButton 的配置
        padding: cupertinoConfig?['padding'] as EdgeInsets?,
      );
    } else {
      return FloatingActionButton(
        onPressed: onPressed,
        child: child,
        // 支持其他 FloatingActionButton 的配置
        backgroundColor: materialConfig?['backgroundColor'] as Color?,
        elevation: materialConfig?['elevation'] as double?,
      );
    }
  }
}
