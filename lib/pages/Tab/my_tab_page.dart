import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_stateful_page.dart';

class MyTabPage extends MyBaseStatefulPage {
  const MyTabPage({super.key});

  @override
  State<MyTabPage> createState() => _MyTabPageState();

  @override
  String get pageTitle => 'TabPage';

  @override
  Color? get pageBackgroundColor => Colors.yellow;
}

class _MyTabPageState extends MyBaseStatefulPageState<MyTabPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          print('add');
        },
        icon: const Icon(Icons.add),
        color: Colors.white, // 保证在蓝色 AppBar 上可见
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  PreferredSizeWidget? buildAppBarBottom(BuildContext context) {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'Tab 1'),
        Tab(text: 'Tab 2'),
        Tab(text: 'Tab 3'),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: const [
        Center(child: Text('Page 1')),
        Center(child: Text('Page 2')),
        Center(child: Text('Page 3')),
      ],
    );
  }
}
