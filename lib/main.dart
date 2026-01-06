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
                  const Text('You have clicked the button this many times:',
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent)),
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
