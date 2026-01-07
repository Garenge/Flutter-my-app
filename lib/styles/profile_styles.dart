import 'package:flutter/material.dart';

/// 个人资料页面样式
///
/// 专门为个人资料功能定义的样式
class ProfileStyles {
  ProfileStyles._(); // 私有构造函数，防止实例化

  // 个人资料页面专用颜色
  static const Color profileHeaderBackground = Colors.deepPurple;
  static const Color profileAvatarBorder = Colors.white;

  // 个人资料文本样式
  static const TextStyle profileName = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle profileEmail = TextStyle(
    fontSize: 14,
    color: Colors.white70,
  );

  static const TextStyle profileSectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );
}


