import 'package:flutter/material.dart';
import 'package:my_app/widgets/unified_page_scaffold.dart';

class MyTabbarPage extends StatefulWidget {
  const MyTabbarPage({super.key});

  @override
  State<MyTabbarPage> createState() => _MyTabbarPageState();
}

class _MyTabbarPageState extends State<MyTabbarPage> {
  int _currentIndex = 0;
  Color _appBarBackgroundColor = Colors.yellow;

  final List<Widget> _pages = [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.green),
  ];

  Color _getAppBarBackgroundColor(int index) {
    return [Colors.yellow, Colors.red, Colors.blue][index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnifiedAppBar(
        title: const Text(
          'Tabbar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            inherit: false,
          ),
        ),
        backgroundColor: _appBarBackgroundColor,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print('index: $index');
            _appBarBackgroundColor = _getAppBarBackgroundColor(index);
            print('appBarBackgroundColor: $_appBarBackgroundColor');
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
