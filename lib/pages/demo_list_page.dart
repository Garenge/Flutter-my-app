import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/base/my_base_page.dart';
import 'package:my_app/models/tool_item.dart';
import 'package:my_app/services/app_style_manager.dart';

/// 通用 Demo 列表页：传入 [items] 即可展示，子项若有 [ToolItem.children] 则点击进入新的列表页
class DemoListPage extends MyBasePage {
  final String _pageTitle;
  final List<ToolItem> items;
  final bool isRoot;

  const DemoListPage({
    super.key,
    required String pageTitle,
    required this.items,
    this.isRoot = false,
  }) : _pageTitle = pageTitle;

  @override
  String get pageTitle => _pageTitle;

  @override
  Color get appBarBackgroundColor => isRoot ? Colors.red : Colors.blue;

  @override
  Color? get pageBackgroundColor => const Color(0xFFF9F9F9);

  @override
  bool get automaticallyImplyLeading => !isRoot;

  @override
  Widget buildBody(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final tool = items[index];
        return _buildToolItem(context, tool);
      },
    );
  }

  void _onToolItemTap(BuildContext context, ToolItem tool) {
    if (tool.isGroup) {
      _navigateToPage(
        context,
        DemoListPage(
          pageTitle: tool.title,
          items: tool.children!,
        ),
      );
    } else {
      tool.onTap!();
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
              color: Colors.black.withOpacity(0.05),
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
          onTap: () => _onToolItemTap(context, tool),
          tileColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => _onToolItemTap(context, tool),
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

  void _navigateToPage(BuildContext context, Widget page) {
    final currentStyle = AppStyleManager.maybeOf(context)?.currentStyle ??
        AppDesignStyle.material;

    if (currentStyle == AppDesignStyle.cupertino) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => page,
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }
  }
}
