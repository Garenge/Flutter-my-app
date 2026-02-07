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
    this.backgroundColor = const Color(0xFFAABBCC),
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
      // 确保 title 的 TextStyle 有明确的 inherit 值，避免切换时的插值问题
      Widget? effectiveTitle = title;
      if (title is Text) {
        final titleText = title as Text;
        if (titleText.style != null) {
          // 如果已有 style，确保 inherit: false
          effectiveTitle = Text(
            titleText.data ?? '',
            style: titleText.style!.copyWith(inherit: false),
            textAlign: titleText.textAlign,
            textDirection: titleText.textDirection,
            locale: titleText.locale,
            softWrap: titleText.softWrap,
            overflow: titleText.overflow,
            textScaleFactor: titleText.textScaleFactor,
            maxLines: titleText.maxLines,
            semanticsLabel: titleText.semanticsLabel,
            textWidthBasis: titleText.textWidthBasis,
            textHeightBehavior: titleText.textHeightBehavior,
          );
        }
      }

      // iOS 导航栏背景色优先级：cupertinoConfig > backgroundColor
      // 这样可以允许通过 cupertinoConfig 覆盖默认的 backgroundColor
      final navBarColor =
          cupertinoConfig?['backgroundColor'] as Color? ?? backgroundColor;

      return CupertinoNavigationBar(
        backgroundColor: navBarColor,
        // 导航阴影
        enableBackgroundFilterBlur: false,
        // 禁用导航栏背景色自动隐藏
        automaticBackgroundVisibility: false,
        border: cupertinoConfig?['border'] as Border? ??
            (cupertinoConfig?['hideBorder'] == true ? null : const Border()),
        automaticallyImplyLeading: automaticallyImplyLeading,
        middle: effectiveTitle,
        leading: leading,
        trailing: actions != null && actions!.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              )
            : null,
      );
    } else {
      // 检查 title 是否已有 TextStyle，如果有则禁用 AppBar 的默认 titleTextStyle
      // 以避免 "Failed to interpolate TextStyles with different inherit values" 错误
      final hasCustomStyle = title is Text && (title as Text).style != null;
      final titleTextStyle = hasCustomStyle
          ? const TextStyle() // 使用空的 TextStyle 禁用主题样式合并
          : (materialConfig?['titleTextStyle'] as TextStyle?);

      return AppBar(
        title: title,
        actions: actions,
        leading: leading,
        backgroundColor:
            backgroundColor ?? materialConfig?['backgroundColor'] as Color?,
        automaticallyImplyLeading: automaticallyImplyLeading,
        toolbarHeight: materialConfig?['toolbarHeight'] as double? ?? 56.0,
        titleTextStyle: titleTextStyle, // 明确设置避免合并冲突
        bottom: materialConfig?['bottom'] as PreferredSizeWidget?,
        // 支持其他 AppBar 的配置
        elevation: materialConfig?['elevation'] as double?,
      );
    }
  }

  @override
  Size get preferredSize {
    final toolbarHeight = materialConfig?['toolbarHeight'] as double? ?? 56.0;
    final bottom = materialConfig?['bottom'] as PreferredSizeWidget?;
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(toolbarHeight + bottomHeight);
  }
}
