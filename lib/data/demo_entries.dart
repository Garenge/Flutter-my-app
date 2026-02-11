import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/models/tool_item.dart';
import 'package:my_app/services/app_style_manager.dart';
import 'package:my_app/widgets/unified_dialogs.dart';
import 'package:my_app/pages/Counter/my_counter_page.dart';
import 'package:my_app/pages/Layout/my_layout_page.dart';
import 'package:my_app/pages/Layout/my_navi_page.dart';
import 'package:my_app/pages/GridView/my_gridView_page.dart';
import 'package:my_app/pages/Tab/my_tabbar_page.dart';
import 'package:my_app/pages/Tab/my_tab_page.dart';
import 'package:my_app/pages/Form/my_textField_page.dart';
import 'package:my_app/pages/Form/my_register_form_page.dart';
import 'package:my_app/pages/Demo/positioned_selector_demo_page.dart';

/// 统一跳转：根据当前 UI 风格选择 Material / Cupertino 路由
void _navigateToPage(BuildContext context, Widget page) {
  final currentStyle = AppStyleManager.maybeOf(context)?.currentStyle ??
      AppDesignStyle.material;
  if (currentStyle == AppDesignStyle.cupertino) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => page),
    );
  } else {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

/// 切换 UI 风格（Material / Cupertino）
Future<void> _handleStyleSwitch(BuildContext context) async {
  final styleNotifier = AppStyleManager.of(context);
  final currentStyle = styleNotifier.currentStyle;
  final targetStyle = currentStyle == AppDesignStyle.material
      ? AppDesignStyle.cupertino
      : AppDesignStyle.material;
  final styleName = targetStyle == AppDesignStyle.material
      ? 'Material Design（谷歌风格）'
      : 'Cupertino（苹果风格）';

  final result = await UnifiedDialogs.showConfirmDialog(
    context: context,
    title: '切换UI风格',
    content: '确定要切换到 $styleName 吗？\n\n切换后界面风格将立即改变。',
  );

  if (result == true) {
    await styleNotifier.toggleStyle();
  }
}

/// 首页根级入口：组件、页面、知识点
List<ToolItem> getRootDemoItems(BuildContext context) {
  return [
    ToolItem(
      title: '组件',
      description: '常用 UI 组件示例：GridView、Tab、TextField、自定义弹出框等',
      icon: Icons.widgets,
      children: _componentItems(context),
    ),
    ToolItem(
      title: '页面',
      description: '完整页面示例：布局、导航、表单等',
      icon: Icons.pages,
      children: _pageItems(context),
    ),
    ToolItem(
      title: '知识点',
      description: '基础交互与风格切换等知识点演示',
      icon: Icons.lightbulb_outline,
      children: _knowledgeItems(context),
    ),
  ];
}

List<ToolItem> _componentItems(BuildContext context) {
  return [
    ToolItem(
      title: 'GridView',
      description: 'GridView 网格布局',
      icon: Icons.grid_view,
      onTap: () => _navigateToPage(context, const MyGridViewPage()),
    ),
    ToolItem(
      title: 'Tabbar',
      description: 'TabBar 标签栏',
      icon: Icons.tab,
      onTap: () => _navigateToPage(context, const MyTabbarPage()),
    ),
    ToolItem(
      title: 'Tab',
      description: 'Tab 标签页',
      icon: Icons.tab,
      onTap: () => _navigateToPage(context, const MyTabPage()),
    ),
    ToolItem(
      title: 'TextField',
      description: '文本框与输入',
      icon: Icons.text_fields,
      onTap: () => _navigateToPage(context, const MyTextFieldPage()),
    ),
    ToolItem(
      title: '自定义弹出框',
      description: '在点击位置弹出选项框，宽100高min(40×项数,120)，点击空白关闭',
      icon: Icons.touch_app,
      onTap: () => _navigateToPage(context, const PositionedSelectorDemoPage()),
    ),
  ];
}

List<ToolItem> _pageItems(BuildContext context) {
  return [
    ToolItem(
      title: '布局页面',
      description: '手写布局代码示例',
      icon: Icons.code,
      onTap: () => _navigateToPage(context, const MyLayoutPage()),
    ),
    ToolItem(
      title: '导航',
      description: '导航 UI 示例',
      icon: Icons.navigation,
      onTap: () => _navigateToPage(context, const MyNaviPage()),
    ),
    ToolItem(
      title: '注册表单',
      description: 'Form 统一校验：姓名年龄性别必填，年龄需为数字，性别仅男/女',
      icon: Icons.person_add,
      onTap: () => _navigateToPage(context, const MyRegisterFormPage()),
    ),
  ];
}

List<ToolItem> _knowledgeItems(BuildContext context) {
  return [
    ToolItem(
      title: '计数器',
      description: '一个简单的计数器，演示基础交互与状态',
      icon: Icons.add_circle_outline,
      onTap: () => _navigateToPage(context, const MyCounterPage()),
    ),
    ToolItem(
      title: '切换UI风格',
      description: '在 Material Design 和 Cupertino 风格之间切换',
      icon: Icons.style,
      onTap: () => _handleStyleSwitch(context),
    ),
  ];
}
