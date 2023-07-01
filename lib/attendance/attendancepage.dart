import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestFile extends StatefulWidget {
  const TestFile({super.key});

  @override
  State<TestFile> createState() => _TestFileState();
}

class _TestFileState extends State<TestFile> {
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
  List<dynamic> booltonum = [];

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
                            booltonum.add(val);

                            setState(() {
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
                  print(map.values.first);
                  newlist.add(map.values.first);
                });
                for (int i = 0; i < _ischecked.length; i++) {
                  print(_ischecked[i]);
                }
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
}

// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';

// class Attendancepage extends StatefulWidget {
//   const Attendancepage({super.key});

//   @override
//   State<Attendancepage> createState() => _AttendancepageState();
// }

// class _AttendancepageState extends State<Attendancepage> {
//   final databaseReference = FirebaseDatabase.instance.ref('attendance');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Realtime Database Demo'),
//       ),
//       body: Center(
//         child: StreamBuilder(
//           stream: databaseReference.child('items').onValue,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               Map<dynamic, dynamic>? values =
//                   snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;

//               List<Item> items = [];
//               values?.forEach((key, value) {
//                 items.add(
//                     Item(name: value['sname'], isChecked: value['isChecked']));
//               });
//               return ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   return CheckboxListTile(
//                     title: Text(items[index].name),
//                     value: items[index].isChecked,
//                     onChanged: (newValue) {
//                       databaseReference
//                           .child('sname')
//                           .child(index.toString())
//                           .update({
//                         'isChecked': newValue,
//                       });
//                     },
//                   );
//                 },
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class Item {
//   String name;
//   bool isChecked;

//   Item({required this.name, required this.isChecked});
// }
