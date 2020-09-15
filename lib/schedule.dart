import 'package:flutter/material.dart';
import 'package:flutter_basic/screens/add_list.dart';
import 'package:flutter_basic/screens/schedule_list.dart';
import 'package:flutter_basic/screens/holiday_list.dart';

class MySchedule extends StatefulWidget {
  @override
  _MyScheduleState createState() => _MyScheduleState();
}

class _MyScheduleState extends State<MySchedule> {
  final items = List<String>.generate(20, (index) => "item ${index + 1}");
  int _selectedIndex = 0;
  final List<Widget> _screens = [ScheduleList(), AddList(), HolidayList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('목록 조회/편집'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('추가'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            title: Text('휴일 선택'),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
