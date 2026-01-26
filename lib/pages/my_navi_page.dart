import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_page.dart';
import 'package:my_app/styles/app_colors.dart';
import 'package:my_app/widgets/unified_text_field.dart';

const logoImage = 'assets/images/login/login_img_logo.png';
const iconChange = 'assets/images/login/login_ic_change-dark.png';

/// 示例页面：演示如何继承 MyBasePage
class MyNaviPage extends MyBasePage {
  const MyNaviPage({super.key});

  /// 标题交给基类的 AppBar 使用
  @override
  String get pageTitle => '布局页面1';

  /// 覆盖页面背景色（相当于 window/view 背景）
  @override
  Color? get pageBackgroundColor => Colors.red;

  /// 覆盖导航栏背景色
  @override
  Color get appBarBackgroundColor => const Color(0xFFFFFFFF);

  /// 构建当前页面的主体内容
  @override
  Widget buildBody(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ClipRRect 包裹整个 Container，只需写一次圆角值
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), // 只写一次 ✨
              child: Container(
                width: 179,
                height: 32,
                child: Image.asset(
                  logoImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              print('touch site');
            },
            child: Container(
              height: 40,
              color: Colors.red,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '中国站',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(iconChange),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              _buildTextInput(context, text: '这是第一行', palceholder: '请输入'),
              const SizedBox(height: 16),
              _buildTextInput(context, text: '这是第二行', palceholder: '请输入'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            spacing: 10,
            children: [
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.red,
                    )),
                    Expanded(
                        child: Container(
                      color: Colors.blue,
                    )),
                    Expanded(
                        child: Container(
                      color: Colors.green,
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  spacing: 5,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: const Color.fromARGB(255, 115, 95, 94),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        color: Colors.blue,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
              color: Colors.green,
              child: const SizedBox(
                height: 100,
                width: 100,
              )),
          Container(
            height: 100,
            color: Colors.red,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                '这个文本高度为100',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  child: const Text(
                    '导航下面整个都是body',
                    style: TextStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }

  Widget _buildTextInput(BuildContext context,
      {String? text, String? palceholder}) {
    OutlineInputBorder getBorder(bool isHighlight) {
      final color = isHighlight ? Colors.grey : AppColors.border;
      final border = OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(
            color: color,
            width: 2,
          ));
      return border;
    }

    return SizedBox(
      height: 44,
      child: UnifiedTextField(
        initialText: text,
        placeholder: palceholder,
        placeholderStyle: const TextStyle(color: AppColors.textPlaceholder),
        // Material 分支仍然沿用你原来的 InputDecoration
        materialDecoration: InputDecoration(
          enabledBorder: getBorder(false),
          disabledBorder: getBorder(false),
          focusedBorder: getBorder(true),
          border: getBorder(false),
        ),
        // Cupertino 分支用 BoxDecoration（CupertinoTextField 的机制不同）
        cupertinoDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.border,
            width: 2,
          ),
        ),
        cupertinoPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
