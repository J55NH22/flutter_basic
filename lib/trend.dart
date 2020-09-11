import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyTrend extends StatefulWidget {
  @override
  MyTrendPageState createState() => MyTrendPageState();
}

class MyTrendPageState extends State<MyTrend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('trend'),
      ),
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'trend'),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<C_Data, String>>[
          LineSeries<C_Data, String>(
              dataSource: <C_Data>[
                C_Data('월요일', 20),
                C_Data('화요일', 10),
                C_Data('수요일', 30),
                C_Data('목요일', 31),
                C_Data('금요일', 41),
                C_Data('토요일', 15),
                C_Data('일요일', 22),
              ],
              xValueMapper: (C_Data cdata, _) => cdata.day,
              yValueMapper: (C_Data cdata, _) => cdata.data,
              dataLabelSettings: DataLabelSettings(isVisible: true)),
        ],
      ),
    );
  }
}

class C_Data {
  C_Data(this.day, this.data);

  final String day;
  final double data;
}
