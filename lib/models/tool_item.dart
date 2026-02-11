import 'package:flutter/material.dart';

/// 列表项模型，支持两种用法：
/// 1. 叶子项：提供 [onTap]，点击跳转具体页面
/// 2. 分组项：提供 [children]，点击进入子列表页
class ToolItem {
  final String title;
  final String description;
  final IconData icon;
  /// 叶子项点击回调，与 [children] 二选一
  final VoidCallback? onTap;
  /// 子列表，有则点击进入子列表页
  final List<ToolItem>? children;

  /// 需提供 [onTap]（叶子项）或非空 [children]（分组项）其一
  const ToolItem({
    required this.title,
    required this.description,
    required this.icon,
    this.onTap,
    this.children,
  });

  /// 是否为分组（有子列表）
  bool get isGroup => children != null && children!.isNotEmpty;
}
