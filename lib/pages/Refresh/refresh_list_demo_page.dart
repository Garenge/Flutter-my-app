import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/widgets/unified_page_scaffold.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class RefreshListDemoPage extends StatefulWidget {
  const RefreshListDemoPage({super.key});

  @override
  State<RefreshListDemoPage> createState() => _RefreshListDemoPageState();
}

class _RefreshListDemoPageState extends State<RefreshListDemoPage> {
  static const int _pageSize = 10;
  static const int _maxPage = 3;

  final RefreshController _refreshController = RefreshController();
  final List<String> _items = List<String>.generate(
    _pageSize,
    (index) => '初始数据 ${index + 1}',
  );

  int _page = 1;
  int _refreshCount = 0;

  Future<void> _handleRefresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    _refreshCount++;
    _page = 1;

    if (!mounted) {
      return;
    }

    setState(() {
      _items
        ..clear()
        ..addAll(
          List<String>.generate(
            _pageSize,
            (index) => '第 $_refreshCount 次刷新后的数据 ${index + 1}',
          ),
        );
    });
    _refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> _handleLoading() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    if (_page >= _maxPage) {
      _refreshController.loadNoData();
      return;
    }

    _page++;
    final nextItems = List<String>.generate(
      _pageSize,
      (index) => '第 $_page 页新增数据 ${index + 1}',
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _items.addAll(nextItems);
    });
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnifiedPageScaffold(
      backgroundColor: const Color(0xFFF4F8FF),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildIntroCard(),
            Expanded(child: _buildRefreshList()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return const UnifiedAppBar(
      title: Text(
        '下拉刷新',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          inherit: false,
        ),
      ),
      backgroundColor: Color(0xFFB8D7FF),
      cupertinoConfig: {
        'hideBorder': true,
      },
      materialConfig: {
        'toolbarHeight': 56.0,
      },
    );
  }

  Widget _buildIntroCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '演示内容',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF17324D),
            ),
          ),
          SizedBox(height: 8),
          Text(
            '向下拖动触发刷新，向上滑到底部触发加载更多。这里用本地延时模拟网络请求，方便观察 pull_to_refresh_flutter3 的完整交互。',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Color(0xFF4A6480),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefreshList() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(
        completeDuration: Duration(milliseconds: 120),
      ),
      footer: const ClassicFooter(
        loadingText: '正在加载更多...',
        canLoadingText: '继续上拉，加载下一页',
        idleText: '上拉加载更多',
        noDataText: '没有更多数据了',
        failedText: '加载失败，请重试',
      ),
      onRefresh: _handleRefresh,
      onLoading: _handleLoading,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        itemCount: _items.length,
        itemBuilder: (context, index) => _buildListItem(index),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    );
  }

  Widget _buildListItem(int index) {
    final label = _items[index];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD9E9FF)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2F5D8A),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF16324F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
