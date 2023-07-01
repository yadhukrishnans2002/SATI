import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sati_1/models/tuser_model.dart';
import 'package:sati_1/timetable/ttimetable_update.dart';
import 'package:zoom_widget/zoom_widget.dart';

class TtimetableScreen extends StatefulWidget {
  const TtimetableScreen({super.key});

  @override
  State<TtimetableScreen> createState() => _TtimetableScreenState();
}

class _TtimetableScreenState extends State<TtimetableScreen> {
  userTimetable updatedValues = userTimetable();
  userTempTimetable temptable = userTempTimetable();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("timetableteacher")
        .doc("ttable")
        .get()
        .then((value) {
      this.updatedValues = userTimetable.fromMap(value.data());
      setState(() {});
      FirebaseFirestore.instance
          .collection("Ttempimetableteacher")
          .doc("temptable")
          .get()
          .then((value) {
        this.temptable = userTempTimetable.fromtempmap(value.data());
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("TimeTable"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Zoom(
        backgroundColor: Colors.white,
        initTotalZoomOut: true,
        maxZoomHeight: 900,
        maxZoomWidth: 650,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "TimeTable",
                textScaleFactor: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  // textDirection: TextDirection.rtl,
                  // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  border: TableBorder.all(width: 2.0, color: Colors.black),
                  children: [
                    TableRow(children: [
                      //! textScaleFactor: 1.5-use this for text size
                      Text(""),
                      Text("1",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("2",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("3",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("4",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("5",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("6",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("7",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                    ]),
                    TableRow(children: [
                      Text(
                        "MON",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${updatedValues.tm1}", textAlign: TextAlign.center),
                      Text("${updatedValues.tm2}", textAlign: TextAlign.center),
                      Text("${updatedValues.tm3}", textAlign: TextAlign.center),
                      Text("${updatedValues.tm4}", textAlign: TextAlign.center),
                      Text("${updatedValues.tm5}", textAlign: TextAlign.center),
                      Text("${updatedValues.tm6}", textAlign: TextAlign.center),
                      Text("${updatedValues.tm7}", textAlign: TextAlign.center),
                    ]),
                    TableRow(children: [
                      Text(
                        "TUE",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${updatedValues.tt1}", textAlign: TextAlign.center),
                      Text("${updatedValues.tt2}", textAlign: TextAlign.center),
                      Text("${updatedValues.tt3}", textAlign: TextAlign.center),
                      Text("${updatedValues.tt4}", textAlign: TextAlign.center),
                      Text("${updatedValues.tt5}", textAlign: TextAlign.center),
                      Text("${updatedValues.tt6}", textAlign: TextAlign.center),
                      Text("${updatedValues.tt7}", textAlign: TextAlign.center),
                    ]),
                    TableRow(children: [
                      Text(
                        "WED",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${updatedValues.tw1}", textAlign: TextAlign.center),
                      Text("${updatedValues.tw2}", textAlign: TextAlign.center),
                      Text("${updatedValues.tw3}", textAlign: TextAlign.center),
                      Text("${updatedValues.tw4}", textAlign: TextAlign.center),
                      Text("${updatedValues.tw5}", textAlign: TextAlign.center),
                      Text("${updatedValues.tw6}", textAlign: TextAlign.center),
                      Text("${updatedValues.tw7}", textAlign: TextAlign.center),
                    ]),
                    TableRow(children: [
                      Text(
                        "THU",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${updatedValues.tth1}",
                          textAlign: TextAlign.center),
                      Text("${updatedValues.tth2}",
                          textAlign: TextAlign.center),
                      Text("${updatedValues.tth3}",
                          textAlign: TextAlign.center),
                      Text("${updatedValues.tth4}",
                          textAlign: TextAlign.center),
                      Text("${updatedValues.tth5}",
                          textAlign: TextAlign.center),
                      Text("${updatedValues.tth6}",
                          textAlign: TextAlign.center),
                      Text("${updatedValues.tth7}",
                          textAlign: TextAlign.center),
                    ]),
                    TableRow(children: [
                      Text(
                        "FRI",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${updatedValues.tf1}", textAlign: TextAlign.center),
                      Text("${updatedValues.tf2}", textAlign: TextAlign.center),
                      Text("${updatedValues.tf3}", textAlign: TextAlign.center),
                      Text("${updatedValues.tf4}", textAlign: TextAlign.center),
                      Text("${updatedValues.tf5}", textAlign: TextAlign.center),
                      Text("${updatedValues.tf6}", textAlign: TextAlign.center),
                      Text("${updatedValues.tf7}", textAlign: TextAlign.center),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Temporary TimeTable",
                textScaleFactor: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  // textDirection: TextDirection.rtl,
                  // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  border: TableBorder.all(width: 2.0, color: Colors.black),
                  children: [
                    TableRow(children: [
                      //! textScaleFactor: 1.5-use this for text size
                      Text(""),
                      Text("1",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("2",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("3",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("4",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("5",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("6",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                      Text("7",
                          textAlign: TextAlign.center, textScaleFactor: 1.3),
                    ]),
                    TableRow(children: [
                      Text("${temptable.nday}", textAlign: TextAlign.center),
                      Text("${temptable.np1}", textAlign: TextAlign.center),
                      Text("${temptable.np2}", textAlign: TextAlign.center),
                      Text("${temptable.np3}", textAlign: TextAlign.center),
                      Text("${temptable.np4}", textAlign: TextAlign.center),
                      Text("${temptable.np5}", textAlign: TextAlign.center),
                      Text("${temptable.np6}", textAlign: TextAlign.center),
                      Text("${temptable.np7}", textAlign: TextAlign.center),
                    ]),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TtimetableUpdate()));
                    },
                    child: Text(
                      "UPDATE",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
