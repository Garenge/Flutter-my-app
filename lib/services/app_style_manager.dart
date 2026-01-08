import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'preference_storage_manager.dart';

/// 应用设计风格枚举
enum AppDesignStyle {
  material, // Material Design (谷歌风格)
  cupertino, // Cupertino (苹果风格)
}

/// 将 AppDesignStyle 枚举转换为字符串
extension AppDesignStyleExtension on AppDesignStyle {
  String get name {
    switch (this) {
      case AppDesignStyle.material:
        return 'material';
      case AppDesignStyle.cupertino:
        return 'cupertino';
    }
  }

  static AppDesignStyle fromString(String? value) {
    switch (value) {
      case 'cupertino':
        return AppDesignStyle.cupertino;
      case 'material':
      default:
        return AppDesignStyle.material;
    }
  }
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
    if (manager == null) {
      throw FlutterError(
        'AppStyleManager not found in context.\n'
        'Make sure you have wrapped your app with AppStyleManager.',
      );
    }
    final notifier = manager.notifier;
    if (notifier == null) {
      throw FlutterError(
        'AppStyleNotifier is null in AppStyleManager.\n'
        'Make sure you have provided a non-null notifier to AppStyleManager.',
      );
    }
    return notifier;
  }

  /// 获取当前风格（不触发重建）
  static AppDesignStyle? read(BuildContext context) {
    final manager = context.findAncestorWidgetOfExactType<AppStyleManager>();
    return manager?.notifier?.currentStyle;
  }

  /// 安全获取 AppStyleNotifier（不抛出异常，找不到时返回 null）
  static AppStyleNotifier? maybeOf(BuildContext context) {
    final manager =
        context.dependOnInheritedWidgetOfExactType<AppStyleManager>();
    return manager?.notifier;
  }
}

/// 风格状态通知器
class AppStyleNotifier extends ChangeNotifier {
  AppDesignStyle _currentStyle = AppDesignStyle.material;
  bool _isInitialized = false;

  AppDesignStyle get currentStyle => _currentStyle;
  bool get isInitialized => _isInitialized;

  /// 根据平台获取默认风格
  /// iOS -> Cupertino, Android/其他 -> Material
  static AppDesignStyle getDefaultStyleByPlatform() {
    if (kIsWeb) {
      // Web 平台默认使用 Material
      return AppDesignStyle.material;
    }
    if (Platform.isIOS) {
      return AppDesignStyle.cupertino;
    } else {
      return AppDesignStyle.material;
    }
  }

  /// 异步初始化风格
  /// 从本地读取保存的风格，如果没有则使用平台默认风格
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // 从本地读取保存的风格
      final savedStyle = await PreferenceStorageManager.getAppDesignStyle();

      if (savedStyle != null) {
        // 如果本地有保存，使用保存的风格
        _currentStyle = AppDesignStyleExtension.fromString(savedStyle);
      } else {
        // 如果本地没有保存，使用平台默认风格
        _currentStyle = getDefaultStyleByPlatform();
        // 保存默认风格到本地
        await PreferenceStorageManager.saveAppDesignStyle(_currentStyle.name);
      }

      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      print('初始化风格失败: $e');
      // 出错时使用平台默认风格
      _currentStyle = getDefaultStyleByPlatform();
      _isInitialized = true;
      notifyListeners();
    }
  }

  /// 切换风格
  Future<void> toggleStyle() async {
    await setStyle(_currentStyle == AppDesignStyle.material
        ? AppDesignStyle.cupertino
        : AppDesignStyle.material);
  }

  /// 设置风格并保存到本地
  Future<void> setStyle(AppDesignStyle style) async {
    if (_currentStyle != style) {
      _currentStyle = style;
      // 保存到本地
      await PreferenceStorageManager.saveAppDesignStyle(style.name);
      notifyListeners();
    }
  }
}
