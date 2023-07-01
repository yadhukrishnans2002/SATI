class tuserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

  tuserModel({this.uid, this.email, this.firstName, this.secondName});

  //taking data from server
  factory tuserModel.fromMap(Map) {
    return tuserModel(
      uid: Map['uid'],
      email: Map['email'],
      firstName: Map['firstName'],
      secondName: Map['secondName'],
    );
  }

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}

class userTimetable {
  String? tm1,
      tm2,
      tm3,
      tm4,
      tm5,
      tm6,
      tm7,
      tt1,
      tt2,
      tt3,
      tt4,
      tt5,
      tt6,
      tt7,
      tw1,
      tw2,
      tw3,
      tw4,
      tw5,
      tw6,
      tw7,
      tth1,
      tth2,
      tth3,
      tth4,
      tth5,
      tth6,
      tth7,
      tf1,
      tf2,
      tf3,
      tf4,
      tf5,
      tf7,
      tf6;

  userTimetable(
      {this.tm1,
      this.tm2,
      this.tm3,
      this.tm4,
      this.tm5,
      this.tm6,
      this.tm7,
      this.tt1,
      this.tt2,
      this.tt3,
      this.tt4,
      this.tt5,
      this.tt6,
      this.tt7,
      this.tw1,
      this.tw2,
      this.tw3,
      this.tw4,
      this.tw5,
      this.tw6,
      this.tw7,
      this.tth1,
      this.tth2,
      this.tth3,
      this.tth4,
      this.tth5,
      this.tth6,
      this.tth7,
      this.tf1,
      this.tf2,
      this.tf3,
      this.tf4,
      this.tf5,
      this.tf6,
      this.tf7});
  //!taking values from db
  factory userTimetable.fromMap(Map) {
    return userTimetable(
      tm1: Map['m1'],
      tm2: Map['m2'],
      tm3: Map['m3'],
      tm4: Map['m4'],
      tm5: Map['m5'],
      tm6: Map['m6'],
      tm7: Map['m7'],
      tt1: Map['t1'],
      tt2: Map['t2'],
      tt3: Map['t3'],
      tt4: Map['t4'],
      tt5: Map['t5'],
      tt6: Map['t6'],
      tt7: Map['t7'],
      tw1: Map['w1'],
      tw2: Map['w2'],
      tw3: Map['w3'],
      tw4: Map['w4'],
      tw5: Map['w5'],
      tw6: Map['w6'],
      tw7: Map['w7'],
      tth1: Map['th1'],
      tth2: Map['th2'],
      tth3: Map['th3'],
      tth4: Map['th4'],
      tth5: Map['th5'],
      tth6: Map['th6'],
      tth7: Map['th7'],
      tf1: Map['f1'],
      tf2: Map['f2'],
      tf3: Map['f3'],
      tf4: Map['f4'],
      tf5: Map['f5'],
      tf6: Map['f6'],
      tf7: Map['f7'],
    );
  }
  //!inserting values to db
  Map<String, dynamic> totimetable() {
    return {
      'm1': tm1,
      'm2': tm2,
      'm3': tm3,
      'm4': tm4,
      'm5': tm5,
      'm6': tm6,
      'm7': tm7,
      't1': tt1,
      't2': tt2,
      't3': tt3,
      't4': tt4,
      't5': tt5,
      't6': tt5,
      't7': tt7,
      'w1': tw1,
      'w2': tw2,
      'w3': tw3,
      'w4': tw4,
      'w5': tw5,
      'w6': tw6,
      'w7': tw7,
      'th1': tth1,
      'th2': tth2,
      'th3': tth3,
      'th4': tth4,
      'th5': tth5,
      'th6': tth6,
      'th7': tth7,
      'f1': tf1,
      'f2': tf2,
      'f3': tf3,
      'f4': tf4,
      'f5': tf5,
      'f6': tf6,
      'f7': tf7,
    };
  }
}

class userTempTimetable {
  String? nday;
  String? np1;
  String? np2;
  String? np3;
  String? np4;
  String? np5;
  String? np6;
  String? np7;
  //!
  userTempTimetable(
      {this.nday,
      this.np1,
      this.np2,
      this.np3,
      this.np4,
      this.np5,
      this.np6,
      this.np7});

  factory userTempTimetable.fromtempmap(Map) {
    return userTempTimetable(
      nday: Map['day'],
      np1: Map['p1'],
      np2: Map['p2'],
      np3: Map['p3'],
      np4: Map['p4'],
      np5: Map['p5'],
      np6: Map['p6'],
      np7: Map['p7'],
    );
  }

  Map<String, dynamic> toTempTimetable() {
    return {
      'day': nday,
      'p1': np1,
      'p2': np2,
      'p3': np3,
      'p4': np4,
      'p5': np5,
      'p6': np6,
      'p7': np7,
    };
  }
}
