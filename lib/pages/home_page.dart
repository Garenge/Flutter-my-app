import 'package:flutter/material.dart';
import 'package:my_app/data/demo_entries.dart';
import 'package:my_app/pages/demo_list_page.dart';

/// 首页：展示「组件 / 页面 / 知识点」三个入口，由 [DemoListPage] 统一渲染列表
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoListPage(
      pageTitle: 'Flutter Demo 工具集',
      items: getRootDemoItems(context),
      isRoot: true,
    );
  }
}
