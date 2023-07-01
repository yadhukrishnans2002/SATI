import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sati_1/models/tuser_model.dart';
import 'package:sati_1/homepages/thome_screen.dart';
import 'package:sati_1/models/user_model.dart';

class TregistrationScreen extends StatefulWidget {
  const TregistrationScreen({super.key});

  @override
  State<TregistrationScreen> createState() => _TregistrationScreenState();
}

class _TregistrationScreenState extends State<TregistrationScreen> {
  DatabaseReference reference = FirebaseDatabase.instance.ref('attendance');

  //!dropdown list
  String dropdownValue = 'computer engineering';
  List<String> options = [
    'computer engineering',
    'computerhardware engineering',
    'instrumentation engineering',
    'mechanical engineering',
    'electrical engineering'
  ];
  final _auth = FirebaseAuth.instance;
  //!our form key
  final _formkey = GlobalKey<FormState>();

  //!editing controllers

  final firstNameEditingController = TextEditingController();
  final secontNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final departmentNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: {} ()
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Cannot be empty");
        }

        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Character(Min 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      //enter adikumbon putiya line varathirikan
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Firstname',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //!second name field
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secontNameEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: {} ()
      validator: (value) {
        RegExp regex = RegExp(r'^.{1,}$');
        if (value!.isEmpty) {
          return ("Cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Character(Min 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        secontNameEditingController.text = value!;
      },
      //!enter adikumbon putiya line varathirikan
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Secondname',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //!department field
    final departmentNameField = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // padding: const EdgeInsets.all(10.0),
          width: 360,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButton<String>(
            value: dropdownValue,
            // icon: Icon(Icons.arrow_downward),
            // iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Color.fromARGB(255, 92, 91, 91)),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },

            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
    // TextFormField(
    //   autofocus: false,
    //   controller: departmentNameController,
    //   keyboardType: TextInputType.emailAddress,
    //   //validator: {} ()
    //   validator: (value) {
    //     RegExp regex = RegExp(r'^.{3,}$');
    //     if (value!.isEmpty) {
    //       return ("Cannot be empty");
    //     }
    //     if (!regex.hasMatch(value)) {
    //       return ("Please Enter Valid Character(Min 3 Character)");
    //     }
    //     return null;
    //   },
    //   onSaved: (value) {
    //     departmentNameController.text = value!;
    //   },
    //   //!enter adikumbon putiya line varathirikan
    //   textInputAction: TextInputAction.next,

    //   decoration: InputDecoration(
    //     prefixIcon: const Icon(Icons.cast_for_education_rounded),
    //     contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //     hintText: 'Departmentname',
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //   ),
    // );

    //!email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: {} ()
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }

        //!reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      //!enter adikumbon putiya line varathirikan
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //!password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: {} ()
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password Required");
        }

        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Character(Min 6 Character)");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      //!enter adikumbon putiya line varathirikan
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //!confirm password field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      //validator: {} ()
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return ("Password dosen't match");
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      //!enter adikumbon putiya line varathirikan
      textInputAction: TextInputAction.done,

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.password),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Confirm Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //!sign up button
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.purple,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            signUp(emailEditingController.text, passwordEditingController.text);
            _addToDatabase(
                "${firstNameEditingController.text} ${secontNameEditingController.text}",
                dropdownValue.toString().trim());
          }
        },
        child: const Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 244, 231, 247),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: Text("Teacher Registration"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: Image.asset(
                        "assets/teacher1.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 45),
                    firstNameField,
                    const SizedBox(height: 20),
                    secondNameField,
                    const SizedBox(height: 20),
                    departmentNameField,
                    const SizedBox(height: 20),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 20),
                    signupButton,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(), postdataforchatting()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.mesaage);
      });
    }
  }

  postDetailsToFirestore() async {
    //!calling our firestore
    //!calling our user model
    //!sending the data
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    tuserModel userModell = tuserModel();
    //!writing all the values
    userModell.email = user!.email;
    userModell.uid = user.uid;
    userModell.firstName = firstNameEditingController.text;
    userModell.secondName = secontNameEditingController.text;
    await firebaseFirestore
        .collection("tusers")
        .doc(user.uid)
        .set(userModell.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const ThomeScreen()),
        (route) => false);

    //!teacher side leave table creation
  }

  postdataforchatting() async {
    //!calling our firestore
    //!calling our user model
    //!sending the data
    String fullName =
        '${firstNameEditingController.text} ${secontNameEditingController.text}';
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    userModel userModell = userModel();
    //!writing all the values
    userModell.email = user!.email;
    userModell.uid = user.uid;
    userModell.firstName = firstNameEditingController.text;
    userModell.secondName = secontNameEditingController.text;
    userModell.completeName = fullName.toString();
    await firebaseFirestore
        .collection("chatforming")
        .doc(user.uid)
        .set(userModell.totcollect());
    print("chat formation sucess");
    // Fluttertoast.showToast(msg: "Account created successfully");
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const homeScreen()),
    //     (route) => false);
  }

  void _addToDatabase(String facuality, String department) {
    FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('leaveapplication')
        .child(department)
        .push()
        .set({'facuality': facuality});

    FirebaseDatabase.instance
        .ref()
        .child('attendance')
        .child('leaveapplication')
        .child('departments')
        .push()
        .set({'department': department});
  }
}
