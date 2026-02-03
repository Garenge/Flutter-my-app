import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_page.dart';

class MyGridViewPage extends MyBasePage {
  const MyGridViewPage({super.key});

  @override
  String get pageTitle => 'GridView 页面';

  @override
  Color? get pageBackgroundColor => Colors.red;

  // 类级别的常量数据列表（所有实例共享）
  static const List<MaterialColor> _dataList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  // 类级别的工具方法（不依赖实例状态，可以改为 static）
  static List<Widget> _getDataList() {
    List<Widget> list = [];
    for (MaterialColor color in _dataList) {
      list.add(Container(
        // color: color,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white)),
      ));
    }
    return list;
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 1)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // GridView 需要明确的高度约束，用 Expanded 包裹
            Expanded(
              child: Scrollbar(
                // 添加滚动条，方便在 Chrome 中用鼠标拖动
                thumbVisibility: true, // 始终显示滚动条（Web 上很有用）
                child: GridView.count(
                  crossAxisCount: 3, // 垂直滚动时是列数，水平滚动时是行数
                  scrollDirection: Axis
                      .vertical, // 滚动方向：Axis.vertical（垂直，默认）或 Axis.horizontal（水平）
                  mainAxisSpacing: 10, // 主轴方向间距（垂直滚动时是行间距，水平滚动时是列间距）
                  crossAxisSpacing: 30, // 交叉轴方向间距（垂直滚动时是列间距，水平滚动时是行间距）
                  childAspectRatio: 1.0, // item 宽高比，1.0 表示正方形（可选）
                  children: [
                    // 使用类名调用，明确表示这是 static 方法
                    ...MyGridViewPage._getDataList(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
