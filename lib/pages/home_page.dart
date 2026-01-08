import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/app_style_manager.dart';
import '../widgets/unified_page_scaffold.dart';
import 'counter_page.dart';

/// 工具模型
class ToolItem {
  final String title;
  final String description;
  final IconData icon;
  final Widget page;

  const ToolItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.page,
  });
}

/// 首页 - 工具列表
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// 获取所有工具列表
  List<ToolItem> _getTools() {
    return [
      const ToolItem(
        title: '计数器',
        description: '一个简单的计数器工具，演示基础的交互功能',
        icon: Icons.add_circle_outline,
        page: CounterPage(),
      ),
      // 后续可以继续添加更多工具
      // ToolItem(
      //   title: '待办事项',
      //   description: '管理您的待办事项列表',
      //   icon: Icons.checklist,
      //   page: TodoPage(),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentStyle = AppStyleManager.maybeOf(context)?.currentStyle ??
        AppDesignStyle.material;

    return UnifiedPageScaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(currentStyle),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  /// 构建 AppBar
  Widget _buildAppBar(AppDesignStyle currentStyle) {
    return const UnifiedAppBar(
      title: Text(
        'Flutter Demo 工具集',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          inherit: false, // 明确设置 inherit 避免样式合并冲突
        ),
      ),
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: false,
      // Cupertino 特定配置
      cupertinoConfig: {
        'hideBorder': true,
      },
      // Material 特定配置
      materialConfig: {
        'toolbarHeight': 56.0,
      },
    );
  }

  /// 构建页面主体
  Widget _buildBody(BuildContext context) {
    final tools = _getTools();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tools.length,
      itemBuilder: (context, index) {
        final tool = tools[index];
        return _buildToolItem(context, tool);
      },
    );
  }

  /// 构建工具列表项
  Widget _buildToolItem(BuildContext context, ToolItem tool) {
    final currentStyle = AppStyleManager.maybeOf(context)?.currentStyle ??
        AppDesignStyle.material;

    // Material 风格
    if (currentStyle == AppDesignStyle.material) {
      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        child: ListTile(
          leading: Icon(tool.icon, size: 32, color: Colors.blue),
          title: Text(
            tool.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            tool.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            _navigateToTool(context, tool);
          },
        ),
      );
    } else {
      // Cupertino 风格
      return GestureDetector(
        onTap: () {
          _navigateToTool(context, tool);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.separator,
                width: 0.5,
              ),
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
                      style: TextStyle(
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

  /// 导航到工具页面
  void _navigateToTool(BuildContext context, ToolItem tool) {
    final currentStyle = AppStyleManager.maybeOf(context)?.currentStyle ??
        AppDesignStyle.material;

    if (currentStyle == AppDesignStyle.cupertino) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => tool.page,
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => tool.page,
        ),
      );
    }
  }
}
