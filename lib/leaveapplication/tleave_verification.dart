import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TleaveVerification extends StatefulWidget {
  final String facultyName;
  const TleaveVerification({super.key, required this.facultyName});

  @override
  State<TleaveVerification> createState() => _TleaveVerificationState();
}

class _TleaveVerificationState extends State<TleaveVerification> {
  @override
  Widget build(BuildContext context) {
    final facultyid = widget.facultyName.toString();
    Query dbRef = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child("leaveapplication")
        .child(facultyid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave verification'),
      ),
      body: Container(
        // color: const Color.fromARGB(255, 245, 238, 248),
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
                  height: 307,
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
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  onPressed: () {
                                    _addToDatabase(
                                        leavedetails['Name'],
                                        leavedetails['Class'],
                                        leavedetails['Rollno'],
                                        leavedetails['Reason'],
                                        leavedetails['Date'],
                                        "Approved");
                                    _deleteData(leavedetails['key'], facultyid);
                                    Fluttertoast.showToast(
                                        msg: "Application approved");
                                  },
                                  child: Text(
                                    "  Accept  ",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .red, // Set the background color to red
                                  ),
                                  onPressed: () {
                                    _addToDatabase(
                                        leavedetails['Name'],
                                        leavedetails['Class'],
                                        leavedetails['Rollno'],
                                        leavedetails['Reason'],
                                        leavedetails['Date'],
                                        "Rejected");
                                    _deleteData(leavedetails['key'], facultyid);
                                    Fluttertoast.showToast(
                                        msg: "Application Rejected");
                                    // Do something when the second button is pressed
                                  },
                                  child: Text(
                                    "  Reject  ",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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

  void _addToDatabase(String sname, String sclass, String rollno, String reason,
      String date, String status) {
    try {
      FirebaseDatabase.instance
          .ref()
          .child('attendance')
          .child('leaveapplication')
          .child(sname)
          .push()
          .set({
        'Name': sname,
        'Class': sclass,
        'Rollno': rollno,
        'Reason': reason,
        'Date': date,
        'status': status,
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error to insert");
    }
  }

  void _deleteData(String k, String tname) async {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('leaveapplication')
        .child(tname);
    reference.child(k).remove();
  }
}
