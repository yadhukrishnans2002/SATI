import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sati_1/models/user_model.dart';
import 'package:sati_1/login/login_screen.dart';

class TprofileScreen extends StatefulWidget {
  const TprofileScreen({super.key});

  @override
  State<TprofileScreen> createState() => _TprofileScreenState();
}

class _TprofileScreenState extends State<TprofileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  userModel loggedUser = userModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("tusers")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedUser = userModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 244, 231, 247),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/teacher1.png", fit: BoxFit.contain),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      "NAME : ${loggedUser.firstName} ${loggedUser.secondName}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "E-MAIL : ${loggedUser.email}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "IDENTITY : Teacher ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              ActionChip(
                backgroundColor: Colors.red,
                label: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                onPressed: () {
                  logOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context1) => const LoginScreen()),
        (route) => false);
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => const TloginScreen()));
  }
}
