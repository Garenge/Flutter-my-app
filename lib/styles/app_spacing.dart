import 'package:flutter/material.dart';

/// 应用间距常量
/// 
/// 统一管理应用中使用的间距值，保持 UI 一致性
class AppSpacing {
  AppSpacing._(); // 私有构造函数，防止实例化

  // 基础间距单位（8px 的倍数，符合 Material Design 规范）
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // 常用间距组合
  static const EdgeInsets paddingSmall = EdgeInsets.all(sm);
  static const EdgeInsets paddingMedium = EdgeInsets.all(md);
  static const EdgeInsets paddingLarge = EdgeInsets.all(lg);

  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(vertical: md);

  // 可以继续添加更多间距定义...
}

