import 'package:flutter/material.dart';

class Tgroupscreen extends StatefulWidget {
  const Tgroupscreen({super.key});

  @override
  State<Tgroupscreen> createState() => _TgroupscreenState();
}

class _TgroupscreenState extends State<Tgroupscreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('group chats'),
      ),
    );
  }
}
