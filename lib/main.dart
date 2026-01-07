import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'styles/app_text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 显示对话框的方法
  void _showHelloDialog() {
    // 这里的 context 是 State 类的属性，不是全局变量
    // _MyHomePageState 继承自 State<MyHomePage>
    // State 类有一个 BuildContext context 属性
    // 所以可以直接使用 this.context（通常省略 this）
    showDialog(
      context: context, // 使用 State 类的 context 属性
      builder: (BuildContext context) {
        // 这里的 context 是 builder 的参数（局部变量）
        // 注意：builder 的 context 和上面的 context 是不同的变量
        return AlertDialog(
          title: Text('Hello, World!'),
          content: Text('This is a dialog'),
          actions: [
            TextButton(
              onPressed: () {
                // 这里使用的是 builder 的 context 参数
                Navigator.of(context).pop(); // 关闭对话框
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 只覆盖 fontSize，保留主题中的其他样式（颜色、字体粗细等）
        titleTextStyle: AppTheme.theme.appBarTheme.titleTextStyle?.copyWith(
          fontSize: 25,
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.max,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.red,
              height: 100,
            ),
            Container(
              color: Colors.yellow,
              child: Column(
                children: [
                  const Text(
                    'You have clicked the button this many times:',
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.rtl,
                    style: AppTextStyles.buttonHintText,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$_counter',
                    style: AppTextStyles.countText,
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
                    color: Colors.green,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: _showHelloDialog,
                        child: Text('Hello, World!'),
                      ),
                    )
                    // 距离上面一个container底部的距离为0, 距离父视图的底部距离为0
                    // margin: const EdgeInsets.only(bottom: 0),
                    // height: 200,
                    // margin: const EdgeInsets.only(bottom: 0),
                    ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
