import 'dart:async';

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
  }

  Timer timer;
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
  int count = 19;
  ChartSeriesController _chartSeriesController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('trend'),
      ),
      body: Column(
        children: [
          SfCartesianChart(
            primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 0)),
            primaryYAxis: NumericAxis(
              axisLine: AxisLine(width: 0),
              majorTickLines: MajorTickLines(width: 0),
            ),
            title: ChartTitle(text: 'trend'),
            series: <ChartSeries<_ChartData, int>>[
              LineSeries<_ChartData, int>(
                  color: Colors.amber,
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
            ],
          ),
          SfCartesianChart(
            primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 0)),
            primaryYAxis: NumericAxis(
              axisLine: AxisLine(width: 0),
              majorTickLines: MajorTickLines(width: 0),
            ),
            title: ChartTitle(text: 'trend2'),
            series: <ChartSeries<_ChartData, int>>[
              LineSeries<_ChartData, int>(
                  color: Colors.blue,
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
            ],
          ),
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
