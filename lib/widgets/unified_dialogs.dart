import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/app_style_manager.dart';

/// 统一的对话框工具类
/// 根据当前风格自动选择 Material 或 Cupertino 对话框
class UnifiedDialogs {
  /// 显示确认对话框
  /// [context] 上下文
  /// [title] 标题
  /// [content] 内容
  /// [style] 可选：强制指定风格
  /// [materialConfig] Material 特定配置
  /// [cupertinoConfig] Cupertino 特定配置
  static Future<bool?> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String content,
    AppDesignStyle? style,
    Map<String, dynamic>? materialConfig,
    Map<String, dynamic>? cupertinoConfig,
  }) async {
    // 如果没有指定风格，从上下文获取
    final currentStyle = style ??
        (AppStyleManager.maybeOf(context)?.currentStyle ??
            AppDesignStyle.material);

    if (currentStyle == AppDesignStyle.cupertino) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cupertinoConfig?['cancelText'] as String? ?? '取消'),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(cupertinoConfig?['confirmText'] as String? ?? '确定'),
              ),
            ],
          );
        },
      );
    } else {
      return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(materialConfig?['cancelText'] as String? ?? '取消'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(materialConfig?['confirmText'] as String? ?? '确定'),
              ),
            ],
          );
        },
      );
    }
  }

  /// 显示简单对话框
  /// [context] 上下文
  /// [title] 标题
  /// [content] 内容
  /// [style] 可选：强制指定风格
  static Future<void> showSimpleDialog({
    required BuildContext context,
    required String title,
    required String content,
    AppDesignStyle? style,
  }) async {
    // 如果没有指定风格，从上下文获取
    final currentStyle = style ??
        (AppStyleManager.maybeOf(context)?.currentStyle ??
            AppDesignStyle.material);

    if (currentStyle == AppDesignStyle.cupertino) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
