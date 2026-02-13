// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_app/main.dart';
import 'package:my_app/services/app_style_manager.dart';

void main() {
  testWidgets('App boots to demo list home', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});

    final styleNotifier = AppStyleNotifier();
    await styleNotifier.initialize();

    await tester.pumpWidget(MyApp(styleNotifier: styleNotifier));
    await tester.pumpAndSettle();

    // Home page title + root entries
    expect(find.text('Flutter Demo 工具集'), findsOneWidget);
    expect(find.text('组件'), findsOneWidget);
    expect(find.text('页面'), findsOneWidget);
    expect(find.text('知识点'), findsOneWidget);
  });
}
