import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/app_style_manager.dart';
import '../theme/app_theme.dart';
import '../theme/cupertino_theme.dart';
import 'debug_corner_indicator.dart';
import 'global_style_toggle_button.dart';

/// 统一的 App 组件
/// 根据当前风格自动选择 MaterialApp 或 CupertinoApp
/// 保持代码统一，但支持风格特定的配置
class UnifiedApp extends StatelessWidget {
  final String title;
  final Widget home;
  final AppDesignStyle? style; // 可选：强制指定风格，不指定则自动检测
  final Map<String, dynamic>? materialConfig; // Material 特定配置
  final Map<String, dynamic>? cupertinoConfig; // Cupertino 特定配置

  const UnifiedApp({
    super.key,
    required this.title,
    required this.home,
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
      // 使用 key 确保风格切换时完全重建，避免动画过渡导致的 TextStyle 插值问题
      return CupertinoApp(
        key: const ValueKey('cupertino_app'),
        title: title,
        debugShowCheckedModeBanner: false,
        theme: cupertinoConfig?['theme'] as CupertinoThemeData? ??
            CupertinoAppTheme.theme,
        builder: (context, child) {
          Widget content = child ?? const SizedBox();
          if (kDebugMode) {
            content = DebugCornerIndicator(child: content);
          }
          return Stack(
            key: const ValueKey('stack_cupertino'),
            children: [
              content,
              const GlobalStyleToggleButton(),
            ],
          );
        },
        home: home,
        // 支持其他 CupertinoApp 的配置
        routes: cupertinoConfig?['routes'] as Map<String, WidgetBuilder>? ??
            const {},
      );
    } else {
      // 使用 key 确保风格切换时完全重建，避免动画过渡导致的 TextStyle 插值问题
      return MaterialApp(
        key: const ValueKey('material_app'),
        title: title,
        debugShowCheckedModeBanner: false,
        theme: materialConfig?['theme'] as ThemeData? ?? AppTheme.theme,
        builder: (context, child) {
          Widget content = child ?? const SizedBox();
          if (kDebugMode) {
            content = DebugCornerIndicator(child: content);
          }
          return Stack(
            key: const ValueKey('stack_material'),
            children: [
              content,
              const GlobalStyleToggleButton(),
            ],
          );
        },
        home: home,
        // 支持其他 MaterialApp 的配置
        routes: materialConfig?['routes'] as Map<String, WidgetBuilder>? ??
            const {},
      );
    }
  }

  /// 静态方法：获取当前风格的 App 主题
  static dynamic getCurrentTheme(BuildContext context) {
    final currentStyle = AppStyleManager.maybeOf(context)?.currentStyle ??
        AppDesignStyle.material;
    return currentStyle == AppDesignStyle.cupertino
        ? CupertinoAppTheme.theme
        : AppTheme.theme;
  }
}
