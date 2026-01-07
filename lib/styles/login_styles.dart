import 'package:flutter/material.dart';

/// 登录页面样式
///
/// 专门为登录功能定义的样式
class LoginStyles {
  LoginStyles._(); // 私有构造函数，防止实例化

  // 登录页面专用颜色
  static const Color loginBackground = Color(0xFFF5F5F5);
  static const Color loginButtonColor = Colors.blue;
  static const Color loginInputBorder = Colors.grey;

  // 登录页面文本样式
  static const TextStyle loginTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle loginHint = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  // 登录按钮样式
  static ButtonStyle get loginButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: loginButtonColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
}

