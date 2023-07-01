import 'package:flutter/material.dart';
import 'package:sati_1/notespage/notespdfpage.dart';
import 'package:sati_1/notespage/notesvideopage.dart';

class NotesScreen extends StatefulWidget {
  final String deptid, semid, subid, modid;
  const NotesScreen(
      {super.key,
      required this.deptid,
      required this.semid,
      required this.subid,
      required this.modid});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  int _currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final deptid = widget.deptid.toString();
    final semid = widget.semid.toString();
    final subid = widget.subid.toString();
    final modid = widget.modid.toString();
    final _pages = [
      NotesPdfScreen(deptid: deptid, semid: semid, subid: subid, modid: modid),
      NotesVideosScreen(
          deptid: deptid, semid: semid, subid: subid, modid: modid),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTES'),
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
              icon: Icon(Icons.picture_as_pdf), label: 'PDF'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection), label: 'VIDEOS'),
        ],
      ),
    );
  }
}
