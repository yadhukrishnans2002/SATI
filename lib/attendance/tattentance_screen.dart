import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TattendancrScreen extends StatefulWidget {
  const TattendancrScreen({super.key});

  @override
  State<TattendancrScreen> createState() => _TattendancrScreenState();
}

class _TattendancrScreenState extends State<TattendancrScreen> {
  String? _selectedItem;
  bool _ischecked = false;
  DateTime _selectedDate = DateTime.now();
  List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  List<String> myList = [];
  //!database reference and query
  Query dbRef =
      FirebaseDatabase.instance.ref().child('attendance').child("studentlist");

  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('attendance');

  //!
  Widget listItem({required Map attendance}) {
    myList.add('${attendance['sname']}');
    List<bool> checkedValues = List.generate(myList.length, (index) => false);

    for (int i = 0; i < myList.length; i++) {
      print(myList[i]);
    }

    return Container(
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(10),
      height: 76,
      color: Color.fromARGB(255, 243, 223, 246),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListView.builder(
          //     itemCount: myList.length,
          //     itemBuilder: (context, index) {
          //       String ite = myList[index];
          //       return CheckboxListTile(
          //         title: Text(
          //           attendance['sname'],
          //           style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          //         ),
          //         value: checkedValues[index],
          //         onChanged: (value) {
          //           setState(() {
          //             checkedValues[index] = value!;
          //           });
          //         },
          //       );
          //     }),
          //!

          CheckboxListTile(
              title: Text(
                attendance['sname'],
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
              value: _ischecked,
              onChanged: (val) {
                setState(() {
                  _ischecked = val!;
                });
              })
        ],
      ),
    );
  }

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
      body: Container(
        child: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map attendance = snapshot.value as Map;
              attendance['key'] = snapshot.key;

              return listItem(attendance: attendance);
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(28, 0, 0, 0),
            child: FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
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
