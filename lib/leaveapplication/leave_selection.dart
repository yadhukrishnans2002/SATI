import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sati_1/leaveapplication/sleavehistory_view.dart';
import 'package:sati_1/models/user_model.dart';
import 'package:sati_1/leaveapplication/leave_department.dart';

class LeaveDeside extends StatefulWidget {
  const LeaveDeside({super.key});

  @override
  State<LeaveDeside> createState() => _LeaveDesideState();
}

class _LeaveDesideState extends State<LeaveDeside> {
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

  @override
  Widget build(BuildContext context) {
    final studentName = "${loggedUser.firstName} ${loggedUser.secondName}";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Leave application"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LeavedepartmentScreen()),
                  );
                },
                child: Text("      Apply leave      "),
              ),
              SizedBox(height: 16), // Add some space between the buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SleaveHistoryScreen(studentName: studentName)),
                  );
                },
                child: Text("Application status"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
