import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sati_1/models/user_model.dart';

class StudentLeave extends StatefulWidget {
  final String facultyName;
  const StudentLeave({super.key, required this.facultyName});

  @override
  State<StudentLeave> createState() => _StudentLeaveState();
}

class _StudentLeaveState extends State<StudentLeave> {
  final _formkey = GlobalKey<FormState>();
  DatabaseReference reference = FirebaseDatabase.instance.ref('attendance');
  User? user = FirebaseAuth.instance.currentUser;
  userModel loggedUser = userModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedUser = userModel.fromMap(value.data());
      setState(() {});
    });
  }

  final TextEditingController _reasonController = TextEditingController();

  final TextEditingController _rollnoController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  DateTime _startDate = DateTime.now();
  // DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final studentName = "${loggedUser.firstName} ${loggedUser.secondName}";
    final facultyid = widget.facultyName.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Application'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    "Leave application to " + facultyid,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    // controller: _nameController,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: studentName,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _classController,
                              decoration: InputDecoration(
                                hintText: 'class',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                              ),
                              maxLines: 1,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Cannot be empty");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _classController.text = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _rollnoController,
                              decoration: InputDecoration(
                                hintText: 'Roll no',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                              ),
                              maxLines: 1,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Cannot be empty");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _rollnoController.text = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _reasonController,
                    decoration: InputDecoration(
                      hintText: 'Enter reason',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Cannot be empty");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _reasonController.text = value!;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Leave Date'),
                            SizedBox(height: 8.0),
                            InkWell(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: _startDate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(3000),
                                );
                                if (picked != null && picked != _startDate) {
                                  setState(() {
                                    _startDate = picked;
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${_startDate.day} / ${_startDate.month} / ${_startDate.year}',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          final sclass = _classController.text;
                          final srollno = _rollnoController.text;
                          final sreason = _reasonController.text;
                          final sdate =
                              '${_startDate.day}/${_startDate.month}/${_startDate.year}';

                          _addToDatabase(facultyid, studentName, sclass,
                              srollno, sreason, sdate);
                          _classController.clear();
                          _rollnoController.clear();
                          _reasonController.clear();
                        }
                      },
                      child: Text('Apply Leave'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addToDatabase(String facultyid, String studentname, String sclass,
      String rollno, String reason, String date) {
    try {
      FirebaseDatabase.instance
          .ref()
          .child('attendance')
          .child('leaveapplication')
          .child(facultyid)
          .push()
          .set({
        'Name': studentname,
        'Class': sclass,
        'Rollno': rollno,
        'Reason': reason,
        'Date': date,
      });
      Fluttertoast.showToast(msg: "Applied Succesfully");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
