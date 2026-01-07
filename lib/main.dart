import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'theme/app_theme.dart';
import 'theme/cupertino_theme.dart';
import 'styles/app_text_styles.dart';
import 'services/app_style_manager.dart';
import 'widgets/global_style_toggle_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 创建全局风格状态管理器
    final styleNotifier = AppStyleNotifier();

    return AppStyleManager(
      notifier: styleNotifier,
      child: ListenableBuilder(
        listenable: styleNotifier,
        builder: (context, _) {
          // 根据风格返回不同的 App
          if (styleNotifier.currentStyle == AppDesignStyle.cupertino) {
            return CupertinoApp(
              title: 'Flutter Demo',
              theme: CupertinoAppTheme.theme,
              builder: (context, child) {
                // 在 CupertinoApp 上添加全局悬浮按钮
                return Stack(
                  children: [
                    child ?? const SizedBox(),
                    const GlobalStyleToggleButton(),
                  ],
                );
              },
              home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
          } else {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.theme,
              builder: (context, child) {
                // 在 MaterialApp 上添加全局悬浮按钮
                return Stack(
                  children: [
                    child ?? const SizedBox(),
                    const GlobalStyleToggleButton(),
                  ],
                );
              },
              home: const MyHomePage(title: 'Flutter Demo Home Page'),
            );
          }
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

  // 显示对话框的方法（根据风格自动切换）
  void _showHelloDialog() {
    final currentStyle = AppStyleManager.of(context).currentStyle;
    if (currentStyle == AppDesignStyle.cupertino) {
      // Cupertino 风格的对话框
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Hello, World!'),
            content: const Text('This is a dialog'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Material 风格的对话框
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hello, World!'),
            content: const Text('This is a dialog'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 从全局状态获取当前风格
    final currentStyle = AppStyleManager.of(context).currentStyle;

    // 根据风格返回不同的页面结构
    if (currentStyle == AppDesignStyle.cupertino) {
      return _buildCupertinoPage();
    } else {
      return _buildMaterialPage();
    }
  }

  // 构建 Material Design 风格的页面
  Widget _buildMaterialPage() {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        backgroundColor: Colors.yellow,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.red,
                height: 100,
              ),
              Container(
                color: Colors.yellow,
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
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _showHelloDialog,
                          child: const Text('Hello, World!'),
                        ),
                        const SizedBox(height: 20),
                        FloatingActionButton(
                          onPressed: _incrementCounter,
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建 Cupertino 风格的页面
  Widget _buildCupertinoPage() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.yellow,
        border: null,
        automaticallyImplyLeading: false,
        middle: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                color: CupertinoColors.systemRed,
                height: 100,
              ),
              Container(
                color: CupertinoColors.systemYellow,
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
              ),
              Expanded(
                child: Container(
                  color: CupertinoColors.systemGreen,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton.filled(
                          onPressed: _showHelloDialog,
                          child: const Text('Hello, World!'),
                        ),
                        const SizedBox(height: 20),
                        CupertinoButton(
                          onPressed: _incrementCounter,
                          child: const Icon(
                            CupertinoIcons.add_circled_solid,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
