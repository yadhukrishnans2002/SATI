import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:sati_1/notesstudent/smodulepage.dart';

class SubjectScreen extends StatefulWidget {
  final String deptid, semid;
  const SubjectScreen({super.key, required this.deptid, required this.semid});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final _subjectController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deptid = widget.deptid.toString();
    final semid = widget.semid.toString();
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('notes')
        .child(deptid)
        .child(semid)
        .child('subject');
    return Scaffold(
      appBar: AppBar(
        title: Text('SUBJECT'),
      ),
      body: Container(
        child: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map subject = snapshot.value as Map;
              subject['key'] = snapshot.key;

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
                          subject['subject'],
                          textAlign: TextAlign.center,
                        ),
                        // trailing: IconButton(
                        //   onPressed: () {
                        //     deleteData(subject['key']);
                        //   },
                        //   icon: Icon(Icons.delete),
                        //   color: Colors.purple,
                        // ),
                        onTap: () {
                          // print(deptid);
                          print(subject['subject']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModuleScreen(
                                    deptid: deptid,
                                    semid: semid,
                                    subid: subject['subject'])),
                          );
                        })
                  ],
                ),
              );
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _showBottomSheet(context);
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
                controller: _subjectController,
                decoration: InputDecoration(hintText: 'Subject'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _addToDatabase(_subjectController.text);
                  // Add department to database here
                  Navigator.pop(context);
                  _subjectController.clear();
                },
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addToDatabase(String subject) {
    final deptid = widget.deptid.toString();
    final semid = widget.semid.toString();
    FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('notes')
        .child(deptid)
        .child(semid)
        .child('subject')
        .push()
        .set({'subject': subject});
  }

  void deleteData(String k) async {
    final deptid = widget.deptid.toString();
    final semid = widget.semid.toString();
    DatabaseReference reference = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('notes')
        .child(deptid)
        .child(semid)
        .child('subject');
    reference.child(k).remove();
  }
}
