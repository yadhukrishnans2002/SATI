import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sati_1/notifications/notification_services.dart';
import 'package:sati_1/models/tuser_model.dart';
import 'package:zoom_widget/zoom_widget.dart';

class TtimetableUpdate extends StatefulWidget {
  const TtimetableUpdate({super.key});

  @override
  State<TtimetableUpdate> createState() => _TtimetableUpdateState();
}

class _TtimetableUpdateState extends State<TtimetableUpdate> {
  final _formkey = GlobalKey<FormState>();

//editing controllerd
  TextEditingController m1 = TextEditingController();
  TextEditingController m2 = TextEditingController();
  TextEditingController m3 = TextEditingController();
  TextEditingController m4 = TextEditingController();
  TextEditingController m5 = TextEditingController();
  TextEditingController m6 = TextEditingController();
  TextEditingController m7 = TextEditingController();
  //
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();
  TextEditingController t6 = TextEditingController();
  TextEditingController t7 = TextEditingController();
  //
  TextEditingController w1 = TextEditingController();
  TextEditingController w2 = TextEditingController();
  TextEditingController w3 = TextEditingController();
  TextEditingController w4 = TextEditingController();
  TextEditingController w5 = TextEditingController();
  TextEditingController w6 = TextEditingController();
  TextEditingController w7 = TextEditingController();
  //
  TextEditingController th1 = TextEditingController();
  TextEditingController th2 = TextEditingController();
  TextEditingController th3 = TextEditingController();
  TextEditingController th4 = TextEditingController();
  TextEditingController th5 = TextEditingController();
  TextEditingController th6 = TextEditingController();
  TextEditingController th7 = TextEditingController();
  //
  TextEditingController f1 = TextEditingController();
  TextEditingController f2 = TextEditingController();
  TextEditingController f3 = TextEditingController();
  TextEditingController f4 = TextEditingController();
  TextEditingController f5 = TextEditingController();
  TextEditingController f6 = TextEditingController();
  TextEditingController f7 = TextEditingController();
  //
  TextEditingController d1 = TextEditingController();
  TextEditingController p1 = TextEditingController();
  TextEditingController p2 = TextEditingController();
  TextEditingController p3 = TextEditingController();
  TextEditingController p4 = TextEditingController();
  TextEditingController p5 = TextEditingController();
  TextEditingController p6 = TextEditingController();
  TextEditingController p7 = TextEditingController();

  // userTimetable insertValues = userTimetable();
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("timetableteacher")
  //       .doc("ttable")
  //       .get()
  //       .then((value) {
  //     this.insertValues = userTimetable.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //!monday periods
    final mon1 = TextFormField(
      controller: m1,
      onSaved: (value) {
        m1.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
      // initialValue: "${insertValues.tm1}".toString(),
    );
    final mon2 = TextFormField(
      controller: m2,
      onSaved: (value) {
        m2.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final mon3 = TextFormField(
      controller: m3,
      onSaved: (value) {
        m3.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final mon4 = TextFormField(
      controller: m4,
      onSaved: (value) {
        m4.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final mon5 = TextFormField(
      controller: m5,
      onSaved: (value) {
        m5.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final mon6 = TextFormField(
      controller: m6,
      onSaved: (value) {
        m6.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final mon7 = TextFormField(
      controller: m7,
      onSaved: (value) {
        m7.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    //!tuesday periods
    final tue1 = TextFormField(
      controller: t1,
      onSaved: (value) {
        t1.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final tue2 = TextFormField(
      controller: t2,
      onSaved: (value) {
        t2.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final tue3 = TextFormField(
      controller: t3,
      onSaved: (value) {
        t3.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final tue4 = TextFormField(
      controller: t4,
      onSaved: (value) {
        t4.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final tue5 = TextFormField(
      controller: t5,
      onSaved: (value) {
        t5.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final tue6 = TextFormField(
      controller: t6,
      onSaved: (value) {
        t6.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final tue7 = TextFormField(
      controller: t7,
      onSaved: (value) {
        t7.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    //!wednesday periods
    final wed1 = TextFormField(
      controller: w1,
      onSaved: (value) {
        w1.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final wed2 = TextFormField(
      controller: w2,
      onSaved: (value) {
        w2.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final wed3 = TextFormField(
      controller: w3,
      onSaved: (value) {
        w3.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final wed4 = TextFormField(
      controller: w4,
      onSaved: (value) {
        w4.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final wed5 = TextFormField(
      controller: w5,
      onSaved: (value) {
        w5.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final wed6 = TextFormField(
      controller: w6,
      onSaved: (value) {
        w6.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final wed7 = TextFormField(
      controller: w7,
      onSaved: (value) {
        w7.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    //!thursdat periods
    final thu1 = TextFormField(
      controller: th1,
      onSaved: (value) {
        th1.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final thu2 = TextFormField(
      controller: th2,
      onSaved: (value) {
        th2.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final thu3 = TextFormField(
      controller: th3,
      onSaved: (value) {
        th3.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final thu4 = TextFormField(
      controller: th4,
      onSaved: (value) {
        th4.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final thu5 = TextFormField(
      controller: th5,
      onSaved: (value) {
        th5.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final thu6 = TextFormField(
      controller: th6,
      onSaved: (value) {
        th6.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final thu7 = TextFormField(
      controller: th7,
      onSaved: (value) {
        th7.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    //!friday periods
    final fri1 = TextFormField(
      controller: f1,
      onSaved: (value) {
        f1.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final fri2 = TextFormField(
      controller: f2,
      onSaved: (value) {
        f2.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final fri3 = TextFormField(
      controller: f3,
      onSaved: (value) {
        f3.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final fri4 = TextFormField(
      controller: f4,
      onSaved: (value) {
        f4.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final fri5 = TextFormField(
      controller: f5,
      onSaved: (value) {
        f5.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final fri6 = TextFormField(
      controller: f6,
      onSaved: (value) {
        f6.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    final fri7 = TextFormField(
      controller: f7,
      onSaved: (value) {
        f7.text = value!.trim();
      },
      style: TextStyle(fontWeight: FontWeight.bold),
    );

    //!temporary timetable
    final days = TextFormField(
      controller: d1,
      onSaved: (value) {
        d1.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
      // initialValue: "${insertValues.tm1}".toString(),
    );
    final per1 = TextFormField(
      controller: p1,
      onSaved: (value) {
        p1.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
      // initialValue: "${insertValues.tm1}".toString(),
    );
    final per2 = TextFormField(
      controller: p2,
      onSaved: (value) {
        p2.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
      // initialValue: "${insertValues.tm1}".toString(),
    );
    final per3 = TextFormField(
      controller: p3,
      onSaved: (value) {
        p3.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
      // initialValue: "${insertValues.tm1}".toString(),
    );
    final per4 = TextFormField(
      controller: p4,
      onSaved: (value) {
        p4.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
      // initialValue: "${insertValues.tm1}".toString(),
    );
    final per5 = TextFormField(
      controller: p5,
      onSaved: (value) {
        p5.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
      // initialValue: "${insertValues.tm1}".toString(),
    );
    final per6 = TextFormField(
      controller: p6,
      onSaved: (value) {
        p6.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
      // initialValue: "${insertValues.tm1}".toString(),
    );
    final per7 = TextFormField(
      controller: p7,
      onSaved: (value) {
        p7.text = value!;
      },
      style: TextStyle(fontWeight: FontWeight.bold),
      // initialValue: "${insertValues.tm1}".toString(),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("TimeTable Update"),
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
        child: Form(
          key: _formkey,
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
                        mon1,
                        mon2,
                        mon3,
                        mon4,
                        mon5,
                        mon6,
                        mon7,
                      ]),
                      TableRow(children: [
                        Text(
                          "TUE",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        tue1,
                        tue2,
                        tue3,
                        tue4,
                        tue5,
                        tue6,
                        tue7,
                      ]),
                      TableRow(children: [
                        Text(
                          "WED",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        wed1,
                        wed2,
                        wed3,
                        wed4,
                        wed5,
                        wed6,
                        wed7,
                      ]),
                      TableRow(children: [
                        Text(
                          "THU",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        thu1,
                        thu2,
                        thu3,
                        thu4,
                        thu5,
                        thu6,
                        thu7,
                      ]),
                      TableRow(children: [
                        Text(
                          "FRI",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        fri1,
                        fri2,
                        fri3,
                        fri4,
                        fri5,
                        fri6,
                        fri7,
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
                        PostTimetableDetails();
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const TtimetableUpdate()));
                      },
                      child: Text(
                        "DONE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
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
                        Text(
                          "DAY",
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                        days,
                        per1,
                        per2,
                        per3,
                        per4,
                        per5,
                        per6,
                        per7,
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
                        PostTempTimetableDetails();
                      },
                      child: Text(
                        "DONE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  NotificationService().showNotification(
                      title: 'Sample title', body: 'It works!');
                },
                child: Text(
                  "message",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future PostTimetableDetails() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    userTimetable UserTimetable = userTimetable();
    try {
      //!wednesday
      UserTimetable.tm1 = m1.text;
      UserTimetable.tm2 = m2.text;
      UserTimetable.tm3 = m3.text;
      UserTimetable.tm4 = m4.text;
      UserTimetable.tm5 = m5.text;
      UserTimetable.tm6 = m6.text;
      UserTimetable.tm7 = m7.text;
      //!tuesdat
      UserTimetable.tt1 = t1.text;
      UserTimetable.tt2 = t2.text;
      UserTimetable.tt3 = t3.text;
      UserTimetable.tt4 = t4.text;
      UserTimetable.tt5 = t5.text;
      UserTimetable.tt6 = t6.text;
      UserTimetable.tt7 = t7.text;
      //!wednesday
      UserTimetable.tw1 = w1.text;
      UserTimetable.tw2 = w2.text;
      UserTimetable.tw3 = w3.text;
      UserTimetable.tw4 = w4.text;
      UserTimetable.tw5 = w5.text;
      UserTimetable.tw6 = w6.text;
      UserTimetable.tw7 = w7.text;
      //!thursday
      UserTimetable.tth1 = th1.text;
      UserTimetable.tth2 = th2.text;
      UserTimetable.tth3 = th3.text;
      UserTimetable.tth4 = th4.text;
      UserTimetable.tth5 = th5.text;
      UserTimetable.tth6 = th6.text;
      UserTimetable.tth7 = th7.text;
      //!friday
      UserTimetable.tf1 = f1.text;
      UserTimetable.tf2 = f2.text;
      UserTimetable.tf3 = f3.text;
      UserTimetable.tf4 = f4.text;
      UserTimetable.tf5 = f5.text;
      UserTimetable.tf6 = f6.text;
      UserTimetable.tf7 = f7.text;

      await firebaseFirestore
          .collection("timetableteacher")
          .doc("ttable")
          .update(UserTimetable.totimetable());
      Fluttertoast.showToast(msg: "value inserted successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "insertion error");
    }
  }

  Future PostTempTimetableDetails() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    userTempTimetable UserTempTimetable = userTempTimetable();
    try {
      UserTempTimetable.nday = d1.text;
      UserTempTimetable.np1 = p1.text;
      UserTempTimetable.np2 = p2.text;
      UserTempTimetable.np3 = p3.text;
      UserTempTimetable.np4 = p4.text;
      UserTempTimetable.np5 = p5.text;
      UserTempTimetable.np6 = p6.text;
      UserTempTimetable.np7 = p7.text;

      await firebaseFirestore
          .collection("Ttempimetableteacher")
          .doc("temptable")
          .update(UserTempTimetable.toTempTimetable());
      Fluttertoast.showToast(msg: "value inserted successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "insertion error");
    }
  }
}
