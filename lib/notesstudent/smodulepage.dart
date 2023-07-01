import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:sati_1/notesstudent/snotespage.dart';

class ModuleScreen extends StatefulWidget {
  final String deptid, semid, subid;
  const ModuleScreen(
      {super.key,
      required this.deptid,
      required this.semid,
      required this.subid});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  final _moduleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final deptid = widget.deptid.toString();
    final semid = widget.semid.toString();
    final subid = widget.subid.toString();
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('notes')
        .child(deptid)
        .child(semid)
        .child(subid)
        .child('modules');
    return Scaffold(
      appBar: AppBar(
        title: Text('MODULE'),
      ),
      body: Container(
        child: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map module = snapshot.value as Map;
              module['key'] = snapshot.key;

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
                          module['module'],
                          textAlign: TextAlign.center,
                        ),
                        // trailing: IconButton(
                        //   onPressed: () {
                        //     deleteData(module['key']);
                        //   },
                        //   icon: Icon(Icons.delete),
                        //   color: Colors.purple,
                        // ),
                        onTap: () {
                          // print(deptid);
                          print(module['module']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotesScreen(
                                    deptid: deptid,
                                    semid: semid,
                                    subid: subid,
                                    modid: module['module'])),
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
                controller: _moduleController,
                decoration: InputDecoration(hintText: 'Module'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _addToDatabase(_moduleController.text);
                  // Add department to database here
                  Navigator.pop(context);
                  _moduleController.clear();
                },
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addToDatabase(String module) {
    final deptid = widget.deptid.toString();
    final semid = widget.semid.toString();
    final subid = widget.subid.toString();
    FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('notes')
        .child(deptid)
        .child(semid)
        .child(subid)
        .child('modules')
        .push()
        .set({'module': module});
  }

  void deleteData(String k) async {
    final deptid = widget.deptid.toString();
    final semid = widget.semid.toString();
    final subid = widget.subid.toString();
    DatabaseReference reference = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('notes')
        .child(deptid)
        .child(semid)
        .child(subid)
        .child('modules');
    reference.child(k).remove();
  }
}
