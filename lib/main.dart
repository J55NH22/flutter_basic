import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/provider/counter.dart';
import 'package:flutter_basic/routes.dart';
import 'package:flutter_swiper/flutter_swiper.Dart';
import 'package:provider/provider.dart';
★★★★★★★★★★★★★★★★★★★
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Counter>(
      create: (_) => Counter(0),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
        home: MyDrawer(),
      ),
    );
  }
}

final List<String> imgList = [
  'http://www.woorizen.com/ko/Images/Energy/becs_function1.png',
  'http://www.woorizen.com/ko/Images/Energy/bems2_1.png',
  'http://www.woorizen.com/ko/Images/Energy/bems2_2.png',
  'http://www.woorizen.com/ko/Images/Energy/bems2_3.png',
];

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    var _counter = counter.getCounter();

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  title: RaisedButton(
                    child: Text('Alarm'),
                    onPressed: () {
                      if (counter.getCounter() > 0) {
                        setState(() {
                          counter.setCounter(0);
                        });
                      }
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'alarm');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  title: RaisedButton(
                    child: Text('Trend'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'trend');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  title: RaisedButton(
                    child: Text('Schedule'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'schedule');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  title: RaisedButton(
                    child: Text('Preferences'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, 'preferences');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            print('알람 확인');
          }),
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, 'search');
              }),
          _alertBadge(),
        ],
      ),
      body: Center(
        child: Container(
          height: 300,
          child: Swiper(
              autoplay: true,
              scale: 0.9,
              viewportFraction: 0.8,
              pagination: SwiperPagination(
                alignment: Alignment.bottomRight,
              ),
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(imgList[index]);
              }),
        ),
      ),
    );
  }

  Widget _alertBadge() {
    final counter = Provider.of<Counter>(context);
    var _counter = counter.getCounter();

    bool show = true;
    if (_counter == 0) {
      show = false;
    }
    return Badge(
      position: BadgePosition.topRight(top: 0, right: 3),
      showBadge: show,
      badgeContent: Text(
        counter.getCounter().toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(
        icon: Icon(Icons.add_alert),
        onPressed: () {
          Navigator.pushNamed(context, 'alarm');
          if (counter.getCounter() > 0) {
            setState(() {
              counter.setCounter(0);
            });
          }
        },
      ),
    );
  }
}
