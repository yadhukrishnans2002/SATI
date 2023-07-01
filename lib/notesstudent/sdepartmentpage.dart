import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:sati_1/notesstudent/ssemesterpage.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  final _departmentController = TextEditingController();
  Query dbRef = FirebaseDatabase.instance
      .ref()
      .child('attendance')
      .child("notes")
      .child('departments');

  DatabaseReference reference = FirebaseDatabase.instance
      .ref()
      .child('attendance')
      .child('notes')
      .child('departments');
  List<String> myList = [];

  Widget listItem({required Map attendance}) {
    myList.add('${attendance['department']}');

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
          ListTile(
              title: Text(
                attendance['department'],
                textAlign: TextAlign.center,
              ),
              // trailing: IconButton(
              //   onPressed: () {
              //     // String k = attendance['ref'];
              //     deleteData(attendance['key']);
              //     //reference.child(attendance['key']).remove();
              //   },
              //   icon: Icon(Icons.delete),
              //   color: Colors.purple,
              // ),
              onTap: () {
                print(attendance['department']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SemesterScreen(
                        itemName: attendance['department'].toString()),
                  ),
                );
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DEPARTMENT'),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // _showBottomSheet(context);
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _departmentController,
                decoration: InputDecoration(hintText: 'Department'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  final department = _departmentController.text;
                  _addToDatabase(_departmentController.text);
                  // Add department to database here
                  Navigator.pop(context);
                  _departmentController.clear();
                },
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addToDatabase(String department) {
    FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('notes')
        .child('departments')
        .push()
        .set({'department': department});
  }

  void deleteData(String k) async {
    reference.child(k).remove();
  }
}
