import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  /// 是否启用输入框（true：启用，false：禁用）
  final bool enabled;
  
  /// 是否为只读模式（true：只读，不能编辑）
  final bool readOnly;
  
  /// 是否自动获取焦点（true：自动获取焦点）
  final bool autofocus;
  
  /// 是否隐藏输入文本（true：隐藏，用于密码输入）
  final bool obscureText;
  
  /// 最大行数（null：不限制）
  final int? maxLines;
  
  /// 最小行数（null：不限制）
  final int? minLines;
  
  /// 最大输入长度（null：不限制）
  final int? maxLength;
  
  /// 是否展开以填充可用空间（true：展开）
  final bool expands;
  
  /// 文本对齐方式
  final TextAlign textAlign;
  
  /// 文本自动大写规则（如首字母大写、每个单词首字母大写等）
  final TextCapitalization textCapitalization;

  /// 焦点节点，用于控制输入框的焦点
  final FocusNode? focusNode;
  
  /// 键盘类型（如数字键盘、邮箱键盘、电话键盘等）
  final TextInputType? keyboardType;
  
  /// 键盘动作按钮（如"完成"、"下一步"等）
  final TextInputAction? textInputAction;
  
  /// 文本内容变化时的回调函数
  final ValueChanged<String>? onChanged;
  
  /// 提交文本时的回调函数（如按下键盘上的完成按钮）
  final ValueChanged<String>? onSubmitted;
  
  /// 输入框被点击时的回调函数
  final GestureTapCallback? onTap;
  
  /// 输入格式限制（如只允许输入数字、限制输入长度等）
  final List<TextInputFormatter>? inputFormatters;
  
  /// 自动填充提示（用于自动填充功能，如用户名、密码等）
  final Iterable<String>? autofillHints;

  /// Cupertino 风格下的内边距
  final EdgeInsetsGeometry cupertinoPadding;

  /// Cupertino 风格的装饰（可设置边框、圆角、背景色等）
  final BoxDecoration? cupertinoDecoration;

  /// Material 风格的输入装饰（可设置标签、提示文本、边框等）
  final InputDecoration? materialDecoration;

  /// 输入文本的样式（如字体大小、颜色、字重等）
  final TextStyle? textStyle;

  /// 占位文本的样式（当输入框没有内容时显示的提示文本样式）
  final TextStyle? placeholderStyle;

  /// 输入框前缀组件（在 Cupertino 中直接显示，在 Material 中会映射到 prefixIcon）
  final Widget? prefix;
  
  /// 输入框后缀组件（在 Cupertino 中直接显示，在 Material 中会映射到 suffixIcon）
  final Widget? suffix;

  /// 清除按钮的显示模式（如总是显示、编辑时显示、从不显示等）
  final OverlayVisibilityMode? clearButtonMode;

  const UnifiedTextField({
    super.key,
    this.style,
    this.initialText,
    this.controller,
    this.placeholder,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.expands = false,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.inputFormatters,
    this.autofillHints,
    this.cupertinoPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.cupertinoDecoration,
    this.materialDecoration,
    this.textStyle,
    this.placeholderStyle,
    this.prefix,
    this.suffix,
    this.clearButtonMode,
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
        readOnly: readOnly,
        autofocus: autofocus,
        obscureText: obscureText,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        expands: expands,
        textAlign: textAlign,
        textCapitalization: textCapitalization,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        controller: effectiveController,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTap: onTap,
        inputFormatters: inputFormatters,
        autofillHints: autofillHints,
        style: textStyle,
        placeholder: placeholder,
        placeholderStyle: placeholderStyle,
        padding: cupertinoPadding,
        prefix: prefix,
        suffix: suffix,
        clearButtonMode: clearButtonMode ?? OverlayVisibilityMode.never,
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

    final effectiveDecoration =
        (materialDecoration ?? const InputDecoration()).copyWith(
      hintText: placeholder,
      hintStyle: placeholderStyle,
      prefixIcon: (materialDecoration?.prefixIcon) ?? prefix,
      suffixIcon: (materialDecoration?.suffixIcon) ?? suffix,
    );

    return TextField(
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      expands: expands,
      textAlign: textAlign,
      textCapitalization: textCapitalization,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: effectiveController,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      style: textStyle,
      decoration: effectiveDecoration,
    );
  }
}

