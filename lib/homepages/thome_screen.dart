import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sati_1/chatapplication/home_page.dart';
import 'package:sati_1/models/user_model.dart';
import 'package:sati_1/attendance/attendancepage.dart';
import 'package:sati_1/leaveapplication/tleave_verification.dart';
import 'package:sati_1/notespage/departmentpage.dart';
import 'package:sati_1/chatapplication/tgroup_screen.dart';
import 'package:sati_1/profile/tprofile_screen.dart';
import 'package:sati_1/timetable/ttimetable_screen.dart';

class ThomeScreen extends StatefulWidget {
  const ThomeScreen({super.key});

  @override
  State<ThomeScreen> createState() => _ThomeScreenState();
}

class _ThomeScreenState extends State<ThomeScreen> {
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

  int _currentSelectedIndex = 0;
  final _pages = [
    const HomePage(),
    const Tgroupscreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final facultyName = "${loggedUser.firstName} ${loggedUser.secondName}";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Portal"),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 244, 231, 247),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName:
                  Text("${loggedUser.firstName} ${loggedUser.secondName}"),
              accountEmail: Text("${loggedUser.email}"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/teacher1.png"),
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_sharp, size: 32),
              iconColor: Colors.purple,
              title: const Text(
                "profile",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TprofileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.apps_outlined, size: 32),
              iconColor: Colors.purple,
              title: const Text(
                "Timetable",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TtimetableScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.verified, size: 32),
              iconColor: Colors.purple,
              title: const Text(
                "Attentance",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestFile()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.note_alt_outlined,
                size: 32,
              ),
              iconColor: Colors.purple,
              title: const Text(
                "Notes",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DepartmentScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.verified_user_outlined,
                size: 32,
              ),
              iconColor: Colors.purple,
              title: const Text(
                "Leave Verification",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                print(facultyName);
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TleaveVerification(facultyName: facultyName)),
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
        currentIndex: _currentSelectedIndex,
        onTap: (newindex) {
          setState(() {
            _currentSelectedIndex = newindex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: 'CHAT'),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined), label: 'GROUPS'),
        ],
      ),
    );
  }
}
