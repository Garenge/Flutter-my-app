import 'package:flutter/material.dart';

/// 首页样式
///
/// 专门为首页功能定义的样式
class HomeStyles {
  HomeStyles._(); // 私有构造函数，防止实例化

  // 首页专用颜色
  static const Color homeCardBackground = Colors.white;
  static const Color homeCardShadow = Colors.black12;

  // 首页文本样式
  static const TextStyle homeTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle homeSubtitle = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  // 首页卡片样式
  static BoxDecoration get homeCardDecoration => BoxDecoration(
        color: homeCardBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: homeCardShadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      );
}
