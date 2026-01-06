import 'package:flutter/material.dart';

/// 应用颜色常量
///
/// 集中管理应用中使用的颜色，便于统一修改和维护
class AppColors {
  AppColors._(); // 私有构造函数，防止实例化

  // 主色调
  static const Color primary = Colors.deepPurple;
  static const Color primaryLight = Colors.deepPurpleAccent;

  // 背景色
  static const Color background = Colors.white;
  static const Color surface = Colors.grey;

  // 文本颜色
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;

  // 功能色
  static const Color success = Colors.green;
  static const Color warning = Colors.yellow;
  static const Color error = Colors.red;
  static const Color info = Colors.blue;

  // 可以继续添加更多颜色...
}
