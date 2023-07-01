import 'package:flutter/material.dart';

class groupScreen extends StatefulWidget {
  const groupScreen({super.key});

  @override
  State<groupScreen> createState() => _groupScreenState();
}

class _groupScreenState extends State<groupScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('group chats'),
      ),
    );
  }
}
