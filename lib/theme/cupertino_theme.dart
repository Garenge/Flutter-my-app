import 'package:flutter/cupertino.dart';

/// Cupertino（Apple）风格主题配置
///
/// 用于配置 iOS 风格的组件样式
class CupertinoAppTheme {
  CupertinoAppTheme._(); // 私有构造函数，防止实例化

  /// Cupertino 主题数据
  static CupertinoThemeData get theme {
    return const CupertinoThemeData(
      // 主色调（iOS 蓝色）
      primaryColor: CupertinoColors.systemBlue,

      // 亮色主题（浅色模式）
      brightness: Brightness.light,

      // 文本主题
      textTheme: CupertinoTextThemeData(
        // 导航栏文本样式
        navTitleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.label,
        ),
        // 大标题样式
        textStyle: TextStyle(
          fontSize: 17,
          color: CupertinoColors.label,
        ),
      ),

      // 背景色
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
    );
  }

  /// 暗色主题（深色模式）
  static CupertinoThemeData get darkTheme {
    return const CupertinoThemeData(
      primaryColor: CupertinoColors.systemBlue,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: CupertinoColors.black,
    );
  }
}
