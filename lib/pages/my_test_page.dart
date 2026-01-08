import 'package:flutter/material.dart';
import 'package:my_app/widgets/unified_page_scaffold.dart';

class MyTestPage extends StatefulWidget {
  const MyTestPage({super.key});

  @override
  State<MyTestPage> createState() => _MyTestPageState();
}

class _MyTestPageState extends State<MyTestPage> {
  @override
  Widget build(BuildContext context) {
    // 使用统一的页面框架，自动根据风格选择
    return UnifiedPageScaffold(
      // 设置整个页面的背景色（包括状态栏和安全区域，相当于 iOS 的 window/view 背景色）
      backgroundColor: Colors.red, // 您可以根据需要修改这个颜色
      appBar: _buildAppBar(),
      body: SafeArea(
          child: Container(
        color: Colors.blue,
      )),
    );
  }

  Widget _buildAppBar() {
    // 移除 const，因为 cupertinoConfig 中包含运行时值
    return const UnifiedAppBar(
      title: Text(
        '自测试页面',
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.pink),
      ),
      backgroundColor: const Color(0xFFAABBFF),
    );
  }
}
