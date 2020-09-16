import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math' as math;

class MyTrend extends StatefulWidget {
  @override
  MyTrendPageState createState() => MyTrendPageState();
}

class MyTrendPageState extends State<MyTrend> {
  MyTrendPageState() {
    timer = Timer.periodic(const Duration(milliseconds: 500), updateDataSource);
    timer2 =
        Timer.periodic(const Duration(milliseconds: 500), updateDataSource2);
  }

  Color c_color1 = Colors.amber;
  Color c_color2 = Colors.blue;

  Timer timer;
  Timer timer2;
  List<_ChartData> chartData = <_ChartData>[
    _ChartData(0, 42),
    _ChartData(1, 47),
    _ChartData(2, 33),
    _ChartData(3, 49),
    _ChartData(4, 54),
    _ChartData(5, 41),
    _ChartData(6, 58),
    _ChartData(7, 51),
    _ChartData(8, 98),
    _ChartData(9, 41),
    _ChartData(10, 53),
    _ChartData(11, 72),
    _ChartData(12, 86),
    _ChartData(13, 52),
    _ChartData(14, 94),
    _ChartData(15, 92),
    _ChartData(16, 86),
    _ChartData(17, 72),
    _ChartData(18, 90),
  ];
  List<_ChartData2> chartData2 = <_ChartData2>[
    _ChartData2(0, 49),
    _ChartData2(1, 40),
    _ChartData2(2, 39),
    _ChartData2(3, 41),
    _ChartData2(4, 51),
    _ChartData2(5, 30),
    _ChartData2(6, 50),
    _ChartData2(7, 60),
    _ChartData2(8, 70),
    _ChartData2(9, 100),
    _ChartData2(10, 40),
    _ChartData2(11, 60),
    _ChartData2(12, 81),
    _ChartData2(13, 41),
    _ChartData2(14, 100),
    _ChartData2(15, 80),
    _ChartData2(16, 71),
    _ChartData2(17, 82),
    _ChartData2(18, 93),
  ];
  int count = 19;
  ChartSeriesController _chartSeriesController;
  ChartSeriesController _chartSeriesController2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('trend'),
      ),
      body: Row(
        children: [
          Column(
            children: [
              SfCartesianChart(
                primaryXAxis:
                    NumericAxis(majorGridLines: MajorGridLines(width: 0)),
                primaryYAxis: NumericAxis(
                  axisLine: AxisLine(width: 0),
                  majorTickLines: MajorTickLines(width: 0),
                ),
                title: ChartTitle(text: 'trend'),
                series: [
                  LineSeries<_ChartData, int>(
                      color: c_color1,
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController = controller;
                      },
                      dataSource: chartData,
                      xValueMapper: (_ChartData cdata, _) => cdata.time,
                      yValueMapper: (_ChartData cdata, _) => cdata.data,
                      animationDuration: 0,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: false,
                          labelAlignment: ChartDataLabelAlignment.top)),
                  ////
                  LineSeries<_ChartData2, int>(
                      color: c_color2,
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController2 = controller;
                      },
                      dataSource: chartData2,
                      xValueMapper: (_ChartData2 cdata, _) => cdata.time,
                      yValueMapper: (_ChartData2 cdata, _) => cdata.data,
                      animationDuration: 0,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: false,
                          labelAlignment: ChartDataLabelAlignment.top)),
                ],
              ),
            ],
          ),
          Column(
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (c_color1 == Colors.amber) {
                      return c_color1 = Color.fromARGB(0, 0, 0, 0);
                    } else {
                      return c_color1 = Colors.amber;
                    }
                  });
                },
                color: Colors.amber,
                child: Text('ChartData1'),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (c_color2 == Colors.blue) {
                      return c_color2 = Color.fromARGB(0, 0, 0, 0);
                    } else {
                      return c_color2 = Colors.blue;
                    }
                  });
                },
                color: Colors.blue,
                child: Text('ChartData2'),
              )
            ],
          )
        ],
      ),
    );
  }

  void updateDataSource(Timer timer) {
    if (chartData != null) {
      chartData.add(_ChartData(count, getRandomInt(10, 200)));
    }
    if (chartData.length == 20) {
      chartData.removeAt(0);
      _chartSeriesController.updateDataSource(
        addedDataIndexes: <int>[chartData.length - 1],
        removedDataIndexes: <int>[0],
      );
    }
    count = count + 1;
  }

  void updateDataSource2(Timer timer) {
    if (chartData2 != null) {
      chartData2.add(_ChartData2(count, getRandomInt(10, 180)));
    }
    if (chartData2.length == 20) {
      chartData2.removeAt(0);
      _chartSeriesController2.updateDataSource(
        addedDataIndexes: <int>[chartData2.length - 1],
        removedDataIndexes: <int>[0],
      );
    }
    count = count + 1;
  }
}

num getRandomInt(num min, num max) {
  final _random = math.Random();
  return min + _random.nextInt(max - min);
}

class _ChartData {
  _ChartData(this.time, this.data);
  final num time;
  final num data;
}

class _ChartData2 {
  _ChartData2(this.time, this.data);
  final num time;
  final num data;
}
