import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_page.dart';

/// 示例页面：演示如何继承 MyBasePage
class MyNaviPage extends MyBasePage {
  const MyNaviPage({super.key});

  /// 标题交给基类的 AppBar 使用
  @override
  String get pageTitle => '布局页面1';

  /// 覆盖页面背景色（相当于 window/view 背景）
  @override
  Color? get pageBackgroundColor => Colors.red;

  /// 覆盖导航栏背景色
  @override
  Color get appBarBackgroundColor => const Color(0xFFAABBFF);

  /// 构建当前页面的主体内容
  @override
  Widget buildBody(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          '导航下面整个都是body',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
