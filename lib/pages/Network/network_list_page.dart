import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/base/my_base_page.dart';
import 'package:my_app/models/tool_item.dart';
import 'package:my_app/services/app_style_manager.dart';
import 'package:my_app/pages/Network/get_request_page.dart';
import 'package:my_app/pages/Network/post_request_page.dart';
import 'package:my_app/pages/Network/future_builder_page.dart';

/// 网络请求列表页面
class NetworkListPage extends MyBasePage {
  const NetworkListPage({super.key});

  @override
  String get pageTitle => '网络请求';

  @override
  Color? get pageBackgroundColor => const Color(0xFFF9F9F9);

  @override
  Widget buildBody(BuildContext context) {
    final items = _getNetworkItems(context);
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final tool = items[index];
        return _buildToolItem(context, tool);
      },
    );
  }

  List<ToolItem> _getNetworkItems(BuildContext context) {
    return [
      ToolItem(
        title: 'GET 请求',
        description: '使用 http.get() 获取数据，包含加载状态和错误处理',
        icon: Icons.download,
        onTap: () => _navigateToPage(context, const GetRequestPage()),
      ),
      ToolItem(
        title: 'POST 请求',
        description: '使用 http.post() 提交数据，包含表单输入和结果展示',
        icon: Icons.upload,
        onTap: () => _navigateToPage(context, const PostRequestPage()),
      ),
      ToolItem(
        title: 'FutureBuilder',
        description: '使用 FutureBuilder 自动处理异步加载状态',
        icon: Icons.sync,
        onTap: () => _navigateToPage(context, const FutureBuilderPage()),
      ),
    ];
  }

  void _navigateToPage(BuildContext context, Widget page) {
    final currentStyle = AppStyleManager.maybeOf(context)?.currentStyle ??
        AppDesignStyle.material;

    if (currentStyle == AppDesignStyle.cupertino) {
      Navigator.of(context).push(
        CupertinoPageRoute(builder: (context) => page),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  Widget _buildToolItem(BuildContext context, ToolItem tool) {
    final currentStyle = AppStyleManager.maybeOf(context)?.currentStyle ??
        AppDesignStyle.material;

    if (currentStyle == AppDesignStyle.material) {
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Icon(tool.icon, size: 28, color: Colors.blue),
          title: Text(
            tool.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            tool.description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          onTap: () => tool.onTap!(),
          tileColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => tool.onTap!(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: CupertinoColors.separator,
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                tool.icon,
                size: 28,
                color: CupertinoColors.systemBlue,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tool.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: CupertinoColors.label,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tool.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: CupertinoColors.secondaryLabel,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                CupertinoIcons.chevron_right,
                size: 18,
                color: CupertinoColors.secondaryLabel,
              ),
            ],
          ),
        ),
      );
    }
  }
}
