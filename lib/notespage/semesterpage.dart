import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sati_1/notespage/subjectpage.dart';

class SemesterScreen extends StatefulWidget {
  final String itemName;
  const SemesterScreen({super.key, required this.itemName});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  final _formkey = GlobalKey<FormState>();
  final _semesterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deptid = widget.itemName.toString();
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child("notes")
        .child(deptid)
        .child('semesters');

    return Scaffold(
      appBar: AppBar(
        title: Text('SEMESTER'),
      ),
      body: Container(
        child: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map semester = snapshot.value as Map;
              semester['key'] = snapshot.key;

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
                          semester['semester'],
                          textAlign: TextAlign.center,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            deleteData(semester['key']);
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.purple,
                        ),
                        onTap: () {
                          // print(deptid);
                          print(semester['semester']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubjectScreen(
                                    deptid: deptid,
                                    semid: semester['semester'])),
                          );
                        })
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _formkey,
          child: Container(
            height: 200.0,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _semesterController,
                  decoration: InputDecoration(hintText: 'Semester'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Cannot be empty");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _semesterController.text = value!;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _addToDatabase(_semesterController.text);
                      // Add department to database here
                      Navigator.pop(context);
                      _semesterController.clear();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addToDatabase(String semester) {
    final deptid = widget.itemName;
    FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('notes')
        .child(deptid)
        .child('semesters')
        .push()
        .set({'semester': semester});
    Fluttertoast.showToast(msg: "Semester Added");
  }

  void deleteData(String k) async {
    final deptid = widget.itemName;
    DatabaseReference reference = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('notes')
        .child(deptid)
        .child('semesters');
    reference.child(k).remove();
    Fluttertoast.showToast(msg: "Semester Deleted");
  }
}
