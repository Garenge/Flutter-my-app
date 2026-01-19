import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_page.dart';

const logoImage = 'assets/images/common/app_icon.png';

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
      padding: const EdgeInsets.all(16),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ClipRRect 包裹整个 Container，只需写一次圆角值
          ClipRRect(
            borderRadius: BorderRadius.circular(50), // 只写一次 ✨
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white, // 不需要 borderRadius，ClipRRect 会裁剪
              ),
              child: Image.asset(
                logoImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
              color: Colors.green,
              child: const SizedBox(
                height: 100,
                width: 100,
              )),
          Container(
            height: 100,
            color: Colors.red,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                '这个文本高度为100',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '导航下面整个都是body',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
