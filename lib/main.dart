import 'package:flutter/material.dart';
import 'services/app_style_manager.dart';
import 'widgets/unified_app.dart';
import 'pages/home_page.dart';

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
          // 使用 key 强制完全重建，避免风格切换时的 TextStyle 插值问题
          return UnifiedApp(
              key: ValueKey(
                  'app_${styleNotifier.currentStyle}'), // 使用风格作为 key 强制完全重建
              title: 'Flutter Demo',
              home: const HomePage());
        },
      ),
    );
  }
}
