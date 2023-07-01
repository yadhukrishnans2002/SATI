import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class SleaveHistoryScreen extends StatefulWidget {
  final String studentName;
  const SleaveHistoryScreen({super.key, required this.studentName});

  @override
  State<SleaveHistoryScreen> createState() => _SleaveHistoryScreenState();
}

class _SleaveHistoryScreenState extends State<SleaveHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child("leaveapplication")
        .child(widget.studentName);
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Status'),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          padding: const EdgeInsets.all(16.0),
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map leavedetails = snapshot.value as Map;
            leavedetails['key'] = snapshot.key;

            return Column(
              children: [
                const Divider(
                  height: 12,
                  color: Colors.white,
                  thickness: 0.0,
                ),
                Container(
                  height: 303,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 223, 144, 247).withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.purple,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            Text(
                              "Name : " + leavedetails['Name'],
                              style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "Roll NO : " + leavedetails['Rollno'],
                              style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              "Class : " + leavedetails['Class'],
                              style: TextStyle(
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 8.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 150,
                                  width: 700,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.purple,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8.0),
                                      Text(
                                        "Leave Date : " + leavedetails['Date'],
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        "Reason : " + leavedetails['Reason'],
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 18.0),
                            Text(
                              "Application Status : " + leavedetails['status'],
                              style: TextStyle(
                                  fontSize: 15.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
