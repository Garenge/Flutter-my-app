import 'package:flutter/material.dart';
import 'package:my_app/widgets/unified_page_scaffold.dart';

/// 带生命周期的页面基类（StatefulWidget 版本）
/// 适用于需要 initState、dispose、TabController 等能力的页面
/// 与 MyBasePage 保持相同的壳（UnifiedPageScaffold、AppBar 等）
abstract class MyBaseStatefulPage extends StatefulWidget {
  const MyBaseStatefulPage({super.key});

  /// 页面标题（子类必须实现）
  String get pageTitle => 'My page';

  /// 整个页面背景色（包括 SafeArea 外），子类可按需重写
  Color? get pageBackgroundColor => Colors.grey[100];

  /// AppBar 背景色，子类可按需重写
  Color get appBarBackgroundColor => Colors.blue;

  /// 是否用 SafeArea 包裹 body，默认 true，子类可重写
  bool get useSafeArea => true;

  /// 右侧按钮（actions），子类可选实现
  List<Widget>? buildActions(BuildContext context) => null;

  /// 左侧 leading，子类可选实现
  Widget? buildLeading(BuildContext context) => null;

  /// 是否自动显示返回按钮，默认 true，子类可重写
  bool get automaticallyImplyLeading => true;
}

/// 对应的 State 基类，子类在此实现 buildBody 及 initState/dispose 等
abstract class MyBaseStatefulPageState<T extends MyBaseStatefulPage>
    extends State<T> {
  /// 页面主体内容（子类必须实现）
  /// 在 State 中实现，可访问 TabController、FocusNode 等需生命周期的对象
  Widget buildBody(BuildContext context);

  /// AppBar 底部（如 TabBar），子类可选重写
  PreferredSizeWidget? buildAppBarBottom(BuildContext context) => null;

  /// AppBar 右侧 actions，子类在 State 中重写此方法更可靠（优先于 widget.buildActions）
  List<Widget>? buildActions(BuildContext context) => widget.buildActions(context);

  @override
  Widget build(BuildContext context) {
    final body = buildBody(context);
    // 有 AppBar 时 body 已在安全区下方，只需 bottom/left/right，避免 top 造成多余空隙
    final wrappedBody = widget.useSafeArea
        ? SafeArea(top: false, child: body)
        : body;

    return UnifiedPageScaffold(
      backgroundColor: widget.pageBackgroundColor,
      appBar: _buildAppBar(context),
      body: wrappedBody,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final bottom = buildAppBarBottom(context);
    final materialConfig = <String, dynamic>{'toolbarHeight': 56.0};
    if (bottom != null) materialConfig['bottom'] = bottom;

    return UnifiedAppBar(
      title: Text(
        widget.pageTitle,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          inherit: false,
        ),
      ),
      backgroundColor: widget.appBarBackgroundColor,
      leading: widget.buildLeading(context),
      actions: buildActions(context),
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      cupertinoConfig: const {'hideBorder': true},
      materialConfig: materialConfig,
    );
  }
}
