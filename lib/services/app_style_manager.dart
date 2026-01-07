import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// 应用设计风格枚举
enum AppDesignStyle {
  material, // Material Design (谷歌风格)
  cupertino, // Cupertino (苹果风格)
}

/// 全局风格状态管理器
class AppStyleManager extends InheritedNotifier<AppStyleNotifier> {
  const AppStyleManager({
    super.key,
    required super.notifier,
    required super.child,
  });

  /// 获取当前风格状态
  static AppStyleNotifier of(BuildContext context) {
    final manager =
        context.dependOnInheritedWidgetOfExactType<AppStyleManager>();
    assert(manager != null, 'AppStyleManager not found in context');
    return manager!.notifier!;
  }

  /// 获取当前风格（不触发重建）
  static AppDesignStyle? read(BuildContext context) {
    final manager = context.findAncestorWidgetOfExactType<AppStyleManager>();
    return manager?.notifier?.currentStyle;
  }
}

/// 风格状态通知器
class AppStyleNotifier extends ChangeNotifier {
  AppDesignStyle _currentStyle = AppDesignStyle.material;

  AppDesignStyle get currentStyle => _currentStyle;

  /// 切换风格
  void toggleStyle() {
    setStyle(_currentStyle == AppDesignStyle.material
        ? AppDesignStyle.cupertino
        : AppDesignStyle.material);
  }

  /// 设置风格
  void setStyle(AppDesignStyle style) {
    if (_currentStyle != style) {
      _currentStyle = style;
      notifyListeners();
    }
  }
}
