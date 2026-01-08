import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../services/app_style_manager.dart';

/// 统一的页面框架组件
/// 根据当前风格自动选择 Scaffold 或 CupertinoPageScaffold
class UnifiedPageScaffold extends StatelessWidget {
  final Widget? appBar;
  final Widget body;
  final Color? backgroundColor; // 整个页面背景色（包括状态栏和安全区域）
  final AppDesignStyle? style; // 可选：强制指定风格
  final Map<String, dynamic>? materialConfig; // Material 特定配置
  final Map<String, dynamic>? cupertinoConfig; // Cupertino 特定配置

  const UnifiedPageScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.backgroundColor,
    this.style,
    this.materialConfig,
    this.cupertinoConfig,
  });

  @override
  Widget build(BuildContext context) {
    // 如果没有指定风格，从上下文获取
    final currentStyle = style ??
        (AppStyleManager.maybeOf(context)?.currentStyle ??
            AppDesignStyle.material);

    if (currentStyle == AppDesignStyle.cupertino) {
      // 如果 appBar 是 UnifiedAppBar，需要先构建它获取实际的 CupertinoNavigationBar
      CupertinoNavigationBar? navigationBar;
      if (appBar is UnifiedAppBar) {
        final builtAppBar = (appBar as UnifiedAppBar).build(context);
        if (builtAppBar is CupertinoNavigationBar) {
          navigationBar = builtAppBar;
        }
      } else if (appBar is CupertinoNavigationBar) {
        navigationBar = appBar as CupertinoNavigationBar;
      }

      // CupertinoPageScaffold 没有 backgroundColor 属性，需要用 Container 包裹
      // 直接使用 Container，color 为 null 时就是透明的，不影响布局
      return CupertinoPageScaffold(
        navigationBar: navigationBar,
        child: Container(
          color: backgroundColor,
          child: body,
        ),
      );
    } else {
      // Material 风格：appBar 可以是 PreferredSizeWidget（包括 UnifiedAppBar）
      return Scaffold(
        appBar: appBar is PreferredSizeWidget
            ? appBar as PreferredSizeWidget
            : null,
        backgroundColor: backgroundColor, // 设置整个 Scaffold 的背景色（包括状态栏区域）
        body: body,
        // 支持其他 Scaffold 的配置
        floatingActionButton:
            materialConfig?['floatingActionButton'] as Widget?,
        drawer: materialConfig?['drawer'] as Widget?,
        endDrawer: materialConfig?['endDrawer'] as Widget?,
        bottomNavigationBar: materialConfig?['bottomNavigationBar'] as Widget?,
      );
    }
  }
}

/// 统一的 AppBar 组件
/// 根据当前风格自动选择 AppBar 或 CupertinoNavigationBar
class UnifiedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final bool automaticallyImplyLeading;
  final AppDesignStyle? style; // 可选：强制指定风格
  final Map<String, dynamic>? materialConfig; // Material 特定配置
  final Map<String, dynamic>? cupertinoConfig; // Cupertino 特定配置

  const UnifiedAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
    this.style,
    this.materialConfig,
    this.cupertinoConfig,
  });

  @override
  Widget build(BuildContext context) {
    // 如果没有指定风格，从上下文获取
    final currentStyle = style ??
        (AppStyleManager.maybeOf(context)?.currentStyle ??
            AppDesignStyle.material);

    if (currentStyle == AppDesignStyle.cupertino) {
      return CupertinoNavigationBar(
        backgroundColor:
            backgroundColor ?? cupertinoConfig?['backgroundColor'] as Color?,
        border: cupertinoConfig?['border'] as Border? ??
            (cupertinoConfig?['hideBorder'] == true ? null : const Border()),
        automaticallyImplyLeading: automaticallyImplyLeading,
        middle: title,
        leading: leading,
        trailing: actions != null && actions!.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              )
            : null,
      );
    } else {
      return AppBar(
        title: title,
        actions: actions,
        leading: leading,
        backgroundColor:
            backgroundColor ?? materialConfig?['backgroundColor'] as Color?,
        automaticallyImplyLeading: automaticallyImplyLeading,
        toolbarHeight: materialConfig?['toolbarHeight'] as double? ?? 56.0,
        // 支持其他 AppBar 的配置
        elevation: materialConfig?['elevation'] as double?,
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
