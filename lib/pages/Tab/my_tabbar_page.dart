import 'package:flutter/material.dart';

class MyTabbarPage extends StatefulWidget {
  const MyTabbarPage({super.key});

  @override
  State<MyTabbarPage> createState() => _MyTabbarPageState();
}

class _MyTabbarPageState extends State<MyTabbarPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Container(color: Colors.red),
    Container(color: Colors.blue),
    Container(color: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
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
