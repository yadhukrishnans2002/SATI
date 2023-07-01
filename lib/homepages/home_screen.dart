import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sati_1/chatgpt/chat_screen.dart';
import 'package:sati_1/models/user_model.dart';
import 'package:sati_1/chatapplication/home_page.dart';
import 'package:sati_1/chatapplication/group_screen.dart';
import 'package:sati_1/leaveapplication/leave_selection.dart';
import 'package:sati_1/notesstudent/sdepartmentpage.dart';
import 'package:sati_1/profile/profile_screen.dart';
import 'package:sati_1/timetable/timetable_screen.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List<String> myData = ['Item 1', 'Item 2', 'Item 3'];
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

  int _currentSelectedIndex = 0;
  final _pages = [
    const HomePage(),
    const groupScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Portal"),
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
                backgroundImage: AssetImage("assets/student.png"),
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle_sharp),
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
                        builder: (context) => const profileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.apps_outlined),
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
                        builder: (context) => const TimetableScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.note_add_sharp),
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
              leading: const Icon(Icons.verified),
              iconColor: Colors.purple,
              title: const Text(
                "Attentance",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TestFile()),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.note),
              iconColor: Colors.purple,
              title: const Text(
                "Leave Application",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LeaveDeside()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.smart_toy_outlined),
              iconColor: Colors.purple,
              title: const Text(
                "Vanessa AI",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.purple,
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatGPTScreen()));
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
              icon: Icon(Icons.wechat_sharp), label: 'CHAT'),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined), label: 'GROUPS'),
        ],
      ),
    );
  }
}
