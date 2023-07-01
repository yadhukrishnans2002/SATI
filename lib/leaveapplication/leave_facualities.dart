import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sati_1/leaveapplication/Leave_apply.dart';

class LeavefacualitiesScreen extends StatefulWidget {
  final String depName;
  const LeavefacualitiesScreen({super.key, required this.depName});

  @override
  State<LeavefacualitiesScreen> createState() => _LeavefacualitiesScreenState();
}

class _LeavefacualitiesScreenState extends State<LeavefacualitiesScreen> {
  @override
  Widget build(BuildContext context) {
    final deptid = widget.depName.toString();
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('leaveapplication')
        .child(deptid);
    // .child('semesters');

    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty'),
      ),
      body: Container(
        child: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map faculty = snapshot.value as Map;
              faculty['key'] = snapshot.key;

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
                          faculty['facuality'],
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          // print(deptid);
                          // print(semester['department']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentLeave(
                                    facultyName: faculty['facuality'])),
                          );
                        })
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
