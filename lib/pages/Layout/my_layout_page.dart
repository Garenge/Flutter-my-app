import 'package:flutter/material.dart';
import 'package:my_app/widgets/unified_page_scaffold.dart';

class MyLayoutPage extends StatefulWidget {
  const MyLayoutPage({super.key});

  @override
  State<MyLayoutPage> createState() => _MyLayoutPageState();
}

class _MyLayoutPageState extends State<MyLayoutPage> {
  @override
  Widget build(BuildContext context) {
    // 获取安全区域的尺寸
    final padding = MediaQuery.of(context).padding;

    // 使用统一的页面框架，自动根据风格选择
    return UnifiedPageScaffold(
      // 设置整个页面的背景色（包括状态栏和安全区域，相当于 iOS 的 window/view 背景色）
      backgroundColor: Colors.red, // 整个页面背景（包括状态栏和底部安全区域）
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // 底部安全区域的内容（可以延伸到 Home Indicator 区域）
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: padding.bottom, // 底部安全区域的高度
            child: Container(
              color: Colors.green, // 底部安全区域的颜色
              child: const Center(
                child: Text(
                  '底部安全区域（Home Indicator 区域）',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          // 主要内容区域（在安全区域内）
          SafeArea(
            child: Stack(
              children: [
                // 背景容器
                Container(
                  color: Colors.blue,
                ),
                // 居中文本（独立定位，不受其他布局影响）
                const Center(
                  child: Text(
                    '主要内容区域2（安全区域内）',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                // 底部内容，固定在底部
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 50,
                    color: Colors.orange,
                    child: const Center(
                      child: Text(
                        '底部内容A',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.red,
                    height: 50,
                    child: const Center(
                      child: Text(
                        '底部内容B',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    // 移除 const，因为 cupertinoConfig 中包含运行时值
    return const UnifiedAppBar(
      title: Text(
        '布局页面',
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.pink),
      ),
      backgroundColor: Color(0xFFAABBFF),
    );
  }
}
