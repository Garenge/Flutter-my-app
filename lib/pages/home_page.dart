import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/app_style_manager.dart';
import '../widgets/unified_page_scaffold.dart';
import '../widgets/unified_dialogs.dart';
import 'counter_page.dart';
import 'my_test_page.dart';

/// 工具模型
class ToolItem {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap; // 点击回调，所有逻辑都在这里处理

  const ToolItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });
}

/// 首页 - 工具列表
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// 获取所有工具列表
  List<ToolItem> _getTools(BuildContext context) {
    return [
      ToolItem(
        title: '计数器',
        description: '一个简单的计数器工具，演示基础的交互功能',
        icon: Icons.add_circle_outline,
        onTap: () {
          _navigateToPage(context, const CounterPage());
        },
      ),
      ToolItem(
        title: '切换UI风格',
        description: '在 Material Design 和 Cupertino 风格之间切换',
        icon: Icons.style,
        onTap: () => _handleStyleSwitch(context),
      ),
      ToolItem(
        title: '自测试页面',
        description: '这个页面, 手写代码',
        icon: Icons.code,
        onTap: () {
          _navigateToPage(context, const MyTestPage());
        },
      ),
      // 后续可以继续添加更多工具
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
      backgroundColor: Colors.red,
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
    final tools = _getTools(context);

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
          onTap: tool.onTap,
        ),
      );
    } else {
      // Cupertino 风格
      return GestureDetector(
        onTap: tool.onTap,
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

  /// 统一的页面跳转方法
  /// 根据当前风格自动选择合适的路由方式
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

  /// 处理风格切换
  void _handleStyleSwitch(BuildContext context) async {
    final styleNotifier = AppStyleManager.of(context);
    final currentStyle = styleNotifier.currentStyle;
    final targetStyle = currentStyle == AppDesignStyle.material
        ? AppDesignStyle.cupertino
        : AppDesignStyle.material;

    final styleName = targetStyle == AppDesignStyle.material
        ? 'Material Design（谷歌风格）'
        : 'Cupertino（苹果风格）';

    final result = await UnifiedDialogs.showConfirmDialog(
      context: context,
      title: '切换UI风格',
      content: '确定要切换到 $styleName 吗？\n\n切换后界面风格将立即改变。',
    );

    if (result == true) {
      // 用户确认，切换风格
      await styleNotifier.toggleStyle();
    }
  }
}
