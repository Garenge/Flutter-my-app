import 'package:flutter/material.dart';

/// 应用主题配置
///
/// Theme 用于配置 Material Design 组件的默认样式
/// 包括 AppBar、Button、Card 等组件的主题
class AppTheme {
  AppTheme._(); // 私有构造函数，防止实例化

  /// 应用主题数据
  static ThemeData get theme {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      // AppBar 主题配置
      appBarTheme: AppBarTheme(
        // Material 3 中，背景色需要使用 surfaceTintColor 或直接设置
        backgroundColor: Colors.blue,
        // 前景色（图标和文字颜色）
        foregroundColor: Colors.deepPurple.shade900,
        // 标题文字样式
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
        // 高度
        toolbarHeight: 60,
        // Material 3 使用 surfaceTintColor 而不是 elevation
        elevation: 0, // Material 3 中 elevation 通常为 0
        surfaceTintColor: Colors.transparent, // Material 3 的表面色调
        // 居中对齐
        centerTitle: true,
        // 图标主题
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
          size: 24,
        ),
        // 确保在 Material 3 中也能应用
        scrolledUnderElevation: 0,
      ),
      // 可以在这里扩展更多主题配置
      textTheme: const TextTheme(
          // 可以添加更多自定义文本样式
          ),
    );
  }
}
