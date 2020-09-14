import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/src/convert_time.dart';
import 'package:provider/provider.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../new_entry_bloc.dart';

class AddList extends StatefulWidget {
  @override
  _AddListState createState() => _AddListState();
}

class System {
  final int id;
  final String name;

  System({
    this.id,
    this.name,
  });
  @override
  String toString() => '$name';
}

class _AddListState extends State<AddList> {
  TextEditingController nameController;
  GlobalKey<ScaffoldState> _scaffoldKey;
  static List<System> _systems = [
    System(id: 1, name: "저수조"),
    System(id: 2, name: "보일러1"),
    System(id: 3, name: "보일러2"),
    System(id: 4, name: "보일러3"),
    System(id: 5, name: "보일러4"),
    System(id: 6, name: "제어1"),
    System(id: 7, name: "제어2"),
    System(id: 8, name: "제어3"),
  ];
  final _items = _systems
      .map((system) => MultiSelectItem<System>(system, system.name))
      .toList();
  List<System> _selectedSystems = [];
  List<System> _selectedSystems2 = [];
  List<System> _selectedSystems3 = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void initState() {
    super.initState();
    nameController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 35),
        children: [
          PanelTitle(
            title: '스케줄 명',
            isRequired: true,
          ),
          TextFormField(
            maxLength: 12,
            style: TextStyle(
              fontSize: 16,
            ),
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
          PanelTitle(
            title: "제어 선택",
            isRequired: true,
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: MultiSelectBottomSheetFormField(
                      initialChildSize: 0.8,
                      maxChildSize: 0.95,
                      title: Text("Systems"),
                      buttonText: Text("Select System"),
                      items: _items,
                      searchable: true,
                      buttonIcon: Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "시스템을 선택하세요";
                        }
                        return null;
                      },
                      onConfirm: (values) {
                        _formKey.currentState.validate();
                        setState(() {
                          _selectedSystems3 = values;
                          print(values);
                        });
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (item) {
                          setState(() {
                            _selectedSystems3.remove(item);
                            _formKey.currentState.validate();
                          });
                        },
                        items: _selectedSystems3
                            .map((e) => MultiSelectItem(e, e.name))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          PanelTitle(
            title: "요일 선택",
            isRequired: true,
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: SelectWeekDays(
              border: false,
              boxDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
              ),
              onSelect: (values) {
                print(values);
              },
            ),
          ),
          PanelTitle(
            title: "시작 시간",
            isRequired: true,
          ),
          SelectTime(),
          PanelTitle(
            title: "종료 시간",
            isRequired: true,
          ),
          SelectTime(),
          PanelTitle(
            title: "휴일 설정",
            isRequired: true,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.08,
              right: MediaQuery.of(context).size.height * 0.08,
            ),
            child: Container(
              height: 50,
              width: 100.0,
              child: FlatButton(
                color: Color(0xFF0099FF),
                shape: StadiumBorder(),
                child: Center(
                  child: Text(
                    "완료",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'schedule');
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class SelectTime extends StatefulWidget {
  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    // final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        // _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
        //     "${convertTime(_time.minute.toString())}");
        print(picked.toString());
      });
    } else {
      print(picked);
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 4),
        child: FlatButton(
          color: Color(0xFF0099FF),
          shape: StadiumBorder(),
          onPressed: () {
            _selectTime(context);
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "시간 선택"
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DateFormat {}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;

  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Color(0xFF3EB16F)),
          ),
        ]),
      ),
    );
  }
}
