import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sati_1/leaveapplication/leave_facualities.dart';

class LeavedepartmentScreen extends StatefulWidget {
  const LeavedepartmentScreen({super.key});

  @override
  State<LeavedepartmentScreen> createState() => _LeavedepartmentScreenState();
}

class _LeavedepartmentScreenState extends State<LeavedepartmentScreen> {
  @override
  Widget build(BuildContext context) {
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child("leaveapplication")
        .child('departments');
    return Scaffold(
      appBar: AppBar(
        title: Text('Department'),
      ),
      body: Container(
        child: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map department = snapshot.value as Map;
              department['key'] = snapshot.key;

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
                          department['department'],
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          // print(deptid);
                          // print(semester['department']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeavefacualitiesScreen(
                                      depName: department['department'],
                                    )),
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
