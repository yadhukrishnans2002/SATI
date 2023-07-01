class userModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? completeName;
  String? identity;

  userModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.completeName,
      this.identity});

  //taking data from server
  factory userModel.fromMap(Map) {
    return userModel(
      uid: Map['uid'],
      email: Map['email'],
      firstName: Map['firstName'],
      secondName: Map['secondName'],
    );
  }

  factory userModel.fromcollect(Map) {
    return userModel(
      uid: Map['uid'],
      email: Map['email'],
      firstName: Map['firstName'],
      secondName: Map['secondName'],
      completeName: Map['fullName'],
      identity: Map['identity'],
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

//!chatforming for student
  Map<String, dynamic> tocollect() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'fullName': completeName,
      'identity': "Student",
    };
  }

  //!chatforming for teacher
  Map<String, dynamic> totcollect() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'fullName': completeName,
      'identity': "Teacher",
    };
  }
}
