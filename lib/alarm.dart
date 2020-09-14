import 'package:flutter/material.dart';
import 'package:flutter_basic/provider/counter.dart';
import 'package:provider/provider.dart';

class MyAlarm extends StatefulWidget {
  MyAlarm({Key key}) : super(key: key);

  @override
  _MyAlarmState createState() => _MyAlarmState();
}

class Alarm {
  bool isDone = false;
  String title;

  Alarm(this.title);
}

class _MyAlarmState extends State<MyAlarm> {
  final _items = <Alarm>[];
  var alarms = '알람';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            _addButtons(),
            Expanded(
                child: ListView(
              children: _items.map((alarm) => _buildItemWidget(alarm)).toList(),
            )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }));
  }

  Widget _addButtons() {
    final counter = Provider.of<Counter>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '${counter.getCounter()}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          RaisedButton.icon(
              onPressed: () {
                _addAlarm(Alarm(alarms));
                counter.add();
                print(counter.getCounter());
              },
              icon: Icon(Icons.add),
              label: Text('Add')),
        ],
      ),
    );
  }

  Widget _buildItemWidget(Alarm alarm) {
    final counter = Provider.of<Counter>(context);

    return ListTile(
      title: Text(
        alarm.title,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          _deleteAlarm(alarm);
          counter.remove();
        },
      ),
    );
  }

  void _addAlarm(Alarm alarm) {
    setState(() {
      _items.add(alarm);
      alarms;
    });
  }

  void _deleteAlarm(Alarm alarm) {
    setState(() {
      _items.remove(alarm);
    });
  }
}
