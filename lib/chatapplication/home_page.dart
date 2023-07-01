//import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sati_1/chatapplication/chat_screen.dart';
import 'package:sati_1/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ChatProvider chatProvider = ChatProvider();
  @override
  void initState() {
    // chatProvider.registerNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chatforming")
            .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: ((context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              userModel user =
                  userModel.fromcollect(snapshot.data!.docs[index]);

              return InkWell(
                autofocus: true,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chat_Screen(
                            uid: user.uid.toString(),
                            uname: user.completeName.toString(),
                            uidentity: user.identity.toString()),
                      ));
                },
                child: Column(
                  children: [
                    ListTile(
                      title: Text(user.completeName.toString()),
                      subtitle: Text(user.identity.toString()),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromARGB(255, 244, 215, 249),
                      ),
                      trailing: const Icon(Icons.school),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider(
                height: 12,
                color: Colors.black45,
                thickness: 1.0,
              );
            },
          );
        }),
      ),
    );
  }
}
