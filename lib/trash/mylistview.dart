import 'package:flutter/material.dart';

import 'package:sati_1/trash/detailpage.dart';

class MyListView extends StatefulWidget {
  final List<String> data;

  MyListView({required this.data});

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widget.data[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(item: widget.data[index]),
              ),
            );
          },
        );
      },
    );
  }
}
