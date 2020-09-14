import 'package:flutter/material.dart';

import 'package:flutter_basic/main.dart';
import 'package:flutter_basic/alarm.dart';
import 'package:flutter_basic/search.dart';
import 'package:flutter_basic/trend.dart';
import 'package:flutter_basic/schedule.dart';
import 'package:flutter_basic/preferences.dart';

final routes = {
  'main': (BuildContext context) => MyApp(),
  'alarm': (BuildContext context) => MyAlarm(),
  'trend': (BuildContext context) => MyTrend(),
  'schedule': (BuildContext context) => MySchedule(),
  'preferences': (BuildContext context) => MyPreferences(),
  'search': (BuildContext context) => MySearch(),
};
