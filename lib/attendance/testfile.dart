import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestFile extends StatefulWidget {
  const TestFile({super.key});

  @override
  State<TestFile> createState() => _TestFileState();
}

class _TestFileState extends State<TestFile> {
  final databaseReference = FirebaseDatabase.instance.ref();
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      // return const Icon(Icons.close);
    },
  );

  List<dynamic> items = [];
  List<dynamic> newlist = [];
  List booltonum = [10];

  String? _selectedItem;
  //bool _ischecked = false;
  DateTime _selectedDate = DateTime.now();

  List<bool> _ischecked = List.filled(5, true);
  //!database reference and query

  final ref = FirebaseDatabase.instance.ref('attendance').child('studentlist');

  //!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        bottom: PreferredSize(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Padding(
                  // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),

                  padding: const EdgeInsets.only(left: 16.0),
                  child: DropdownButton<String>(
                    value: _selectedItem,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue;
                      });
                    },
                    items: <String>[
                      'period 1',
                      'period 2',
                      'period 3',
                      'period 4',
                      'period 5',
                      'period 6',
                      'period 7',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 40,
                    underline: Container(),
                    iconEnabledColor: Colors.white, //Icon color
                    style: TextStyle(
                        //te
                        color: Colors.white, //Font color
                        fontSize: 20 //font size on dropdown button
                        ),
                    dropdownColor: Colors.purple,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
              ),
              Container(
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.calendar_month, color: Colors.white),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null && picked != _selectedDate) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                DateFormat('dd/MM/yyyy').format(_selectedDate),
                style: TextStyle(
                    //te
                    color: Colors.white, //Font color
                    fontSize: 20 //font size on dropdown button
                    ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(30.0),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: ref.onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                List<bool> checked = List<bool>.filled(items.length, false);
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;
                  items.clear();
                  items = map.values.toList();
                  return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context, Index) {
                      return SwitchListTile(
                          title: Text(
                            items[Index]['sname'],
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                          value: _ischecked[Index],
                          onChanged: (bool val) {
                            setState(() {
                              print(val);
                              booltonum.add(val);
                              _ischecked[Index] = val;
                            });
                          });
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(28, 0, 0, 0),
            child: FloatingActionButton.extended(
              onPressed: () {
                items.forEach((map) {
                  //   print(map.values.first);
                  //newlist.add(map.values.first);
                });
                items.forEach((element) {
                  Map<String, dynamic> map = Map<String, dynamic>.from(element);
                  newlist.add(map['sname']);
                });
                for (int i = 0; i < items.length; i++) {
                  print(_ischecked[i]);
                }
                for (int i = 0; i < items.length; i++) {
                  print(newlist[i]);
                }
                print(_selectedItem);
                //makeputAttendancejson();
              },
              label: const Text('ADD'),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }

  // void display() {
  //   items.forEach((map) {
  //     print(map.values.first);
  //     newlist.add(map.values.first);
  //   });
  //   print(booltonum.length);
  //   for (int i = 0; i < _ischecked.length; i++) {
  //     print(_ischecked[i]);
  //   }
  // }

  void makeputAttendancejson() {
    for (int i = 0; i < items.length; i++) {
      if (_selectedItem == 'period 1') {
        print('if worked');
        databaseReference
            .child("attendance")
            .child(newlist[i])
            .child("$_selectedDate")
            .set({
          'date': '$_selectedDate',
          'period1': '${_ischecked[i]}',
        });
      }
    }
    // databaseReference
    //     .child("attendance")
    //     .child("")
    //     .child("${_selectedDate}")
    //     .set({
    //   'date': 'date',
    //   'period1': 'per1',
    //   'period2': 'per2',
    //   'period3': 'per3',
    //   'period4': 'per4',
    //   'period5': 'per5',
    //   'period6': 'per6',
    //   'period7': 'per7',
    // });
  }
}
