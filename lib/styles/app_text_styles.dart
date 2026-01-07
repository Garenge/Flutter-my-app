import 'package:flutter/material.dart';

/// 应用文本样式集合
///
/// 用于定义应用中常用的文本样式
class AppTextStyles {
  AppTextStyles._(); // 私有构造函数，防止实例化

  /// 计数器文本样式
  static const TextStyle countText = TextStyle(
    color: Colors.red,
    fontSize: 50,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
    fontFamily: 'Menlo',
  );

  /// 标题文本样式
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  /// 副标题文本样式
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  /// 正文文本样式
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  /// 小文本样式
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black54,
  );

  /// 按钮点击提示文本样式
  static const TextStyle buttonHintText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.deepPurpleAccent,
  );

  // 可以继续添加更多文本样式...
}
