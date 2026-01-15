import 'package:flutter/material.dart';
import 'package:my_app/widgets/unified_page_scaffold.dart';

/// 通用页面基类，相当于 iOS 里的基类 ViewController
/// 负责：
/// - 包一层 UnifiedPageScaffold
/// - 统一导航栏样式
/// - 统一是否使用 SafeArea
/// 子类只需要关心：标题 + body 内容
abstract class MyBasePage extends StatelessWidget {
  const MyBasePage({super.key});

  /// 页面标题（子类必须实现）
  String get pageTitle => 'My page';

  /// 整个页面背景色（包括 SafeArea 外），子类可按需重写
  Color? get pageBackgroundColor => Colors.grey[100];

  /// AppBar 背景色，子类可按需重写
  Color get appBarBackgroundColor => Colors.blue;

  /// 是否用 SafeArea 包裹 body，默认 true，子类可重写
  bool get useSafeArea => true;

  /// 页面主体内容（子类必须实现）
  Widget buildBody(BuildContext context);

  /// 右侧按钮（actions），子类可选实现
  List<Widget>? buildActions(BuildContext context) => null;

  /// 左侧 leading，子类可选实现
  Widget? buildLeading(BuildContext context) => null;

  /// 是否自动显示返回按钮，默认 true，子类可重写
  bool get automaticallyImplyLeading => true;

  @override
  Widget build(BuildContext context) {
    final body = buildBody(context);
    final wrappedBody = useSafeArea ? SafeArea(child: body) : body;

    return UnifiedPageScaffold(
      backgroundColor: pageBackgroundColor,
      appBar: buildAppBar(context),
      body: wrappedBody,
    );
  }

  Widget buildAppBar(BuildContext context) {
    return UnifiedAppBar(
      title: Text(
        pageTitle,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          inherit: false, // 明确避免 TextStyle 插值冲突
        ),
      ),
      backgroundColor: appBarBackgroundColor,
      leading: buildLeading(context),
      actions: buildActions(context),
      automaticallyImplyLeading: automaticallyImplyLeading,
      cupertinoConfig: const {
        'hideBorder': true,
      },
      materialConfig: const {
        'toolbarHeight': 56.0,
      },
    );
  }
}
