import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'styles/app_text_styles.dart';
import 'services/app_style_manager.dart';
import 'widgets/unified_app.dart';
import 'widgets/unified_page_scaffold.dart';
import 'widgets/unified_buttons.dart';
import 'widgets/unified_dialogs.dart';

void main() async {
  // 确保 Flutter 绑定已初始化（用于异步操作）
  WidgetsFlutterBinding.ensureInitialized();

  // 创建全局风格状态管理器并初始化
  final styleNotifier = AppStyleNotifier();
  await styleNotifier.initialize();

  runApp(MyApp(styleNotifier: styleNotifier));
}

class MyApp extends StatelessWidget {
  final AppStyleNotifier styleNotifier;

  const MyApp({
    super.key,
    required this.styleNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return AppStyleManager(
      notifier: styleNotifier,
      child: ListenableBuilder(
        listenable: styleNotifier,
        builder: (context, _) {
          // 等待初始化完成
          if (!styleNotifier.isInitialized) {
            // 显示加载界面
            return const UnifiedApp(
              title: 'Flutter Demo',
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          // 使用统一 App 组件，自动根据风格选择
          return const UnifiedApp(
            title: 'Flutter Demo',
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 显示对话框的方法（使用统一对话框工具，自动根据风格切换）
  void _showHelloDialog() {
    UnifiedDialogs.showSimpleDialog(
      context: context,
      title: 'Hello, World!',
      content: 'This is a dialog',
    );
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前风格，用于颜色选择（可以统一，也可以风格特定）
    final currentStyle = AppStyleManager.maybeOf(context)?.currentStyle ??
        AppDesignStyle.material;

    // 使用统一的页面框架，自动根据风格选择
    return UnifiedPageScaffold(
      // 设置整个页面的背景色（包括状态栏和安全区域，相当于 iOS 的 window/view 背景色）
      backgroundColor: Colors.red, // 您可以根据需要修改这个颜色
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildBody(currentStyle),
      ),
    );
  }

  /// 构建 AppBar
  Widget _buildAppBar() {
    return UnifiedAppBar(
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.yellow,
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

  /// 构建页面主体内容
  Widget _buildBody(AppDesignStyle currentStyle) {
    final colors = _getColors(currentStyle);

    return Column(
      children: <Widget>[
        _buildTopContainer(colors['top']!),
        _buildMiddleContainer(colors['middle']!),
        Expanded(
          child: _buildBottomContainer(colors['bottom']!, currentStyle),
        ),
      ],
    );
  }

  /// 获取颜色配置
  Map<String, Color> _getColors(AppDesignStyle currentStyle) {
    return {
      'top': currentStyle == AppDesignStyle.cupertino
          ? CupertinoColors.systemBlue
          : Colors.red,
      'middle': currentStyle == AppDesignStyle.cupertino
          ? CupertinoColors.systemYellow
          : Colors.yellow,
      'bottom': currentStyle == AppDesignStyle.cupertino
          ? CupertinoColors.systemGreen
          : Colors.green,
    };
  }

  /// 构建顶部容器
  Widget _buildTopContainer(Color color) {
    return Container(
      color: color,
      height: 100,
    );
  }

  /// 构建中间容器（计数器区域）
  Widget _buildMiddleContainer(Color color) {
    return Container(
      color: color,
      child: Column(
        children: [
          const Text(
            'You have clicked the button this many times:',
            textAlign: TextAlign.left,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.buttonHintText,
          ),
          const SizedBox(height: 20),
          Text(
            '$_counter',
            style: AppTextStyles.countText,
          ),
        ],
      ),
    );
  }

  /// 构建底部容器（按钮区域）
  Widget _buildBottomContainer(Color color, AppDesignStyle currentStyle) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UnifiedButton(
              filled: true,
              onPressed: _showHelloDialog,
              child: const Text('Hello, World!'),
            ),
            const SizedBox(height: 20),
            UnifiedFloatingActionButton(
              onPressed: _incrementCounter,
              child: currentStyle == AppDesignStyle.cupertino
                  ? const Icon(
                      CupertinoIcons.add_circled_solid,
                      size: 40,
                    )
                  : const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
