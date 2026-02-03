import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_page.dart';

class MyTabPage extends MyBasePage {
  const MyTabPage({super.key});

  @override
  String get pageTitle => 'TabPage';

  @override
  Color? get pageBackgroundColor => Colors.yellow;

  @override
  Widget buildBody(BuildContext context) {
    return Container();
  }
}
