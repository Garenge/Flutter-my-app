import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/app_style_manager.dart';

/// 统一的输入框组件
/// - Material 风格：使用 [TextField]
/// - Cupertino 风格：使用 [CupertinoTextField]
class UnifiedTextField extends StatelessWidget {
  /// 可选：强制指定风格；不指定则从 [AppStyleManager] 读取
  final AppDesignStyle? style;

  /// 初始文本（不传 controller 时会临时创建 controller）
  final String? initialText;

  /// Material TextField 的 controller
  final TextEditingController? controller;

  /// Cupertino placeholder（Material 对应 hintText）
  final String? placeholder;

  final bool enabled;
  final ValueChanged<String>? onChanged;

  /// Cupertino 侧 padding
  final EdgeInsetsGeometry cupertinoPadding;

  /// Cupertino 侧装饰（边框/圆角/背景）
  final BoxDecoration? cupertinoDecoration;

  /// Material 侧 InputDecoration
  final InputDecoration? materialDecoration;

  /// 文字样式（两端共用）
  final TextStyle? textStyle;

  /// placeholder/hint 的文字样式（两端共用）
  final TextStyle? placeholderStyle;

  const UnifiedTextField({
    super.key,
    this.style,
    this.initialText,
    this.controller,
    this.placeholder,
    this.enabled = true,
    this.onChanged,
    this.cupertinoPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.cupertinoDecoration,
    this.materialDecoration,
    this.textStyle,
    this.placeholderStyle,
  });

  @override
  Widget build(BuildContext context) {
    final currentStyle = style ??
        (AppStyleManager.maybeOf(context)?.currentStyle ??
            AppDesignStyle.material);

    // 注意：这里如果没传 controller，则会创建临时 controller。
    // 如果你希望输入内容可编辑且不被重建重置，建议在 StatefulWidget 中管理 controller。
    final effectiveController =
        controller ?? TextEditingController(text: initialText);

    if (currentStyle == AppDesignStyle.cupertino) {
      return CupertinoTextField(
        enabled: enabled,
        controller: effectiveController,
        onChanged: onChanged,
        style: textStyle,
        placeholder: placeholder,
        placeholderStyle: placeholderStyle,
        padding: cupertinoPadding,
        decoration: cupertinoDecoration ??
            BoxDecoration(
              color: CupertinoColors.systemBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: CupertinoColors.separator,
                width: 0.5,
              ),
            ),
      );
    }

    return TextField(
      enabled: enabled,
      controller: effectiveController,
      onChanged: onChanged,
      style: textStyle,
      decoration: (materialDecoration ?? const InputDecoration()).copyWith(
        hintText: placeholder,
        hintStyle: placeholderStyle,
      ),
    );
  }
}

