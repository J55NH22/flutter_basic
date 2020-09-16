import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleTimeSeriesChart extends StatefulWidget {
  final int max_chart_count = 20;
  List<charts.Series> seriesList;
  bool animate = false;
  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  //랜덤 값
  List<TimeSeriesSales> qdata = List();
  List<TimeSeriesSales> qdata2 = List();

  factory SimpleTimeSeriesChart.withRandomData() {
    return SimpleTimeSeriesChart(_createRandomData());
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> _createRandomData() {
    var data = [
      TimeSeriesSales(DateTime(2017, 9, 26), 25),
      TimeSeriesSales(DateTime(2017, 10, 3), 100),
      TimeSeriesSales(DateTime(2017, 10, 10), 75),
      TimeSeriesSales(DateTime(2017, 10, 10), 70),
    ];

    var data2 = [
      TimeSeriesSales(DateTime(2017, 9, 30), 25),
      TimeSeriesSales(DateTime(2017, 10, 10), 100),
      TimeSeriesSales(DateTime(2017, 10, 70), 75),
      TimeSeriesSales(DateTime(2017, 10, 50), 70),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  List<charts.Series<TimeSeriesSales, DateTime>> _update() {
    final random = Random();
    //var time = DateTime(2017, 9, 19, 18, 30);
    var time = DateTime.now();

    print(time);
    if (!qdata.isEmpty && qdata.length > max_chart_count) qdata.removeAt(0);
    qdata.add(TimeSeriesSales(time, random.nextInt(100)));

    if (!qdata2.isEmpty && qdata2.length > max_chart_count) qdata2.removeAt(0);
    qdata2.add(TimeSeriesSales(time, random.nextInt(150)));

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: qdata,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: qdata2,
      )
    ];
  }

  @override
  _SimpleTimeSeriesChartState createState() => _SimpleTimeSeriesChartState();
}

class _SimpleTimeSeriesChartState extends State<SimpleTimeSeriesChart> {
  @override
  void initState() {
    var time = DateTime.now();
    var mtime = DateTime.now();

    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //data[3] = TimeSeriesSales(time, random.nextInt(100));
      widget.seriesList = widget._update();
      setState(() {});
      //dataList.add(new TimeSeriesSales(time, random.nextInt(100)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      widget.seriesList,
      animate: false, //widget.animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

class MyTrend2 extends StatefulWidget {
  @override
  _MyTrend2State createState() => _MyTrend2State();
}

class _MyTrend2State extends State<MyTrend2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trend'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 5, child: SimpleTimeSeriesChart.withRandomData())
        ],
      )),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
