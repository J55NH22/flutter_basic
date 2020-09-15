import 'package:flutter/material.dart';

class HolidayList extends StatefulWidget {
  @override
  _HolidayListState createState() => _HolidayListState();
}

class _HolidayListState extends State<HolidayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holiday'),
      ),
    );
  }
}
