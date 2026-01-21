import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_page.dart';
import 'package:my_app/styles/app_colors.dart';

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
          Container(
            height: 40,
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
          Column(
            children: [
              _buildTextInput(context, text: '这是第一行', palceholder: '请输入'),
              const SizedBox(height: 8),
              _buildTextInput(context, text: '这是第二行', palceholder: '请输入'),
            ],
          ),
          const SizedBox(
            height: 10,
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

    return Container(
        height: 44,
        child: TextField(
          enabled: true,
          controller: TextEditingController(text: text),
          decoration: InputDecoration(
            hintText: palceholder,
            enabledBorder: getBorder(false),
            disabledBorder: getBorder(false),
            focusedBorder: getBorder(true),
            border: getBorder(false),
          ),
        ));
  }
}
