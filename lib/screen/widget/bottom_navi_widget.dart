import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../map.dart';
import '../myPage.dart';
import '../reminder.dart';
import '../widgetmain.dart';
import 'IndexProvider.dart';

class MainScreen extends StatefulWidget { // bottomNavigationBar로 이동하기.
  // final int initialIndex;

  // const MainScreen({super.key, this.initialIndex = 0}); // map.dart에서 인덱스 설정 해보려고 변경함. 오류시 아래 주석 풀기.
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedIndex = widget.initialIndex; // 초기화.
  // }

  final List<Widget> screens = [
    MapPage(),         // 지도 페이지
    FigmaToCodeApp(),  // main 페이지
    Reminder(),        // 검색 페이지 들어가야 함.
    MyPage(),          // 프로필 페이지
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<IndexProvider>().selectedIndex;
    return Scaffold(
      // body: screens[_selectedIndex],
      body: SafeArea(
        child: screens.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xEF537052),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: ' ',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            context.read<IndexProvider>().setIndex(index);
            // _selectedIndex = index;
          });
        },
      ),
    );
  }
  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }
}
