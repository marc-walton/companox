import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companox/Homepage.dart';
import 'package:companox/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  bool loging =false;
   bool _passwordVisible = false;

  final DateTime timestamp = DateTime.now();
 
  @override
  initState() {

    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }
  Future<User> signInWithGoogle() async {
    loging =  true;

    User user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print('The account already exists with a different credential.');
        } else if (e.code == 'invalid-credential') {
          print('Error occurred while accessing credentials. Try again.');
        }
      } catch (e) {
        print(e);
      }
    }
    // 1) check if user exists in users collection in database (according to their id)
    DocumentSnapshot doc = await usersRef.doc(user.uid).get();
    // 2) if the user doesn't exist, then we want to take them to the create account page
    if (!doc.exists) {
      usersRef.doc(user.uid).set({
        "id": user.uid,
        "username" : user.displayName,
        "photoUrl": user.photoURL,
        "email": user.email,
        "displayName": user.displayName,
        "next": 0,
        "answered":false,
        "Q28-32":false,
        "age":0,
        "2":10,
        "3":10,
        "4":10,
        "5":10,
        "6":10,
        "7":10,
        "8":10,
        "9":10,
        "10":10,
        "11":10,
        "12":10,
        "13":10,
        "14":10,
        "15":10,
        "16":10,
        "17":10,
        "18":10,
        "19":10,
        "20":10,
        "21":10,
        "22":10,
        "23":10,
        "24":10,
        "25":10,
        "26":10,
        "27":10,
        "28":10,
        "29":10,
        "30":10,
        "31":10,
        "32":10,
        "33":10,
        "34":10,
        "35":10,
        "36":10,
        "37":10,
        "38":10,
        "39":10,
        "40":10,
        "41":10,
        "42":10,
        "43":10,
        "44":10,
        "totalPoints":0,

      });
      doc = await usersRef.doc(user.uid).get();
    }
    currentUser = Users.fromDocument(doc);
    loging =  false;
    if(currentUser.id != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Homepage(
                    userid: user.uid,
                    auth: true,
                  )),
              (_) => false);
    }
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: loging,
        child:Scaffold(

            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text("Register", style: TextStyle(color:Colors.white),),
            ),
            body: Container(
                         padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                    child: Form(
                      key: _registerFormKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(color:Colors.black),
                            decoration: InputDecoration(
                                labelStyle:  TextStyle(color:Colors.black),
                                hintStyle:  TextStyle(color:Colors.black),
                                labelText: 'Full Name', hintText: "Full Name"),
                            controller: firstNameInputController,
                            validator: (value) {
                              // ignore: missing_return
                              if (value.length < 3) {
                                return "Please enter a valid name";
                              }
                            },
                          ),
                          // TextFormField(
                          //     style: TextStyle(color:Colors.black),
                          //     decoration: InputDecoration(
                          //         labelStyle:  TextStyle(color:Colors.black),
                          //         hintStyle:  TextStyle(color:Colors.black),                              labelText: 'User Name*', hintText: "unique to you on Fashure "),
                          //     controller: lastNameInputController,
                          //     validator: (value) {
                          //       if (value.length < 3) {
                          //         return "Please enter a valid user name.";
                          //       }
                          //     }),
                          TextFormField(
                            style: TextStyle(color:Colors.black),
                            decoration: InputDecoration(
                                labelStyle:  TextStyle(color:Colors.black),
                                hintStyle:  TextStyle(color:Colors.black),                            labelText: 'Email', hintText: "john.doe@gmail.com"),
                            controller: emailInputController,
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                          ),
                          TextFormField(
                            style: TextStyle(color:Colors.black),
                            decoration: InputDecoration(
                              labelStyle:  TextStyle(color:Colors.black),
                              hintStyle:  TextStyle(color:Colors.black),
                              labelText: 'Password', hintText: "", suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),),
                            controller: pwdInputController,
                            obscureText: _passwordVisible,
                            validator: pwdValidator,
                          ),
                          TextFormField(
                            style: TextStyle(color:Colors.black),
                            decoration: InputDecoration(
                              labelStyle:  TextStyle(color:Colors.black),
                              hintStyle:  TextStyle(color:Colors.black),
                              labelText: 'Confirm Password', hintText: "Confirm Password",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),

                            ),
                            controller: confirmPwdInputController,
                            obscureText: _passwordVisible,
                            validator: pwdValidator,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation : 0.1,

                              primary:  Colors.white.withOpacity(0.1), // background
                            ),
                            child: Text("Register",        style: TextStyle(color:Colors.white),),
                            onPressed: () {


                                  if (_registerFormKey.currentState.validate()) {
                                if (pwdInputController.text ==
                                    confirmPwdInputController.text) {
                                  try {
                                    loging = true;
                                    FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                        email: emailInputController.text,
                                        password: pwdInputController.text)
                                        .then((ser) async  { FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(ser.user.uid)
                                        .set({
                                      "id": ser.user.uid,
                                      "username" : firstNameInputController.text,
                                      "photoUrl": "https://firebasestorage.googleapis.com/v0/b/companox.appspot.com/o/favicon-32x32.png?alt=media&token=ef959703-6079-4216-b28c-37403d1d6fc7",
                                      "email": emailInputController.text,
                                      "displayName": firstNameInputController.text,
                                      "next": 0,
                                      "answered":false,
                                      "Q28-32":false,
                                      "age":0,
                                      "2":10,
                                      "3":10,
                                      "4":10,
                                      "5":10,
                                      "6":10,
                                      "7":10,
                                      "8":10,
                                      "9":10,
                                      "10":10,
                                      "11":10,
                                      "12":10,
                                      "13":10,
                                      "14":10,
                                      "15":10,
                                      "16":10,
                                      "17":10,
                                      "18":10,
                                      "19":10,
                                      "20":10,
                                      "21":10,
                                      "22":10,
                                      "23":10,
                                      "24":10,
                                      "25":10,
                                      "26":10,
                                      "27":10,
                                      "28":10,
                                      "29":10,
                                      "30":10,
                                      "31":10,
                                      "32":10,
                                      "33":10,
                                      "34":10,
                                      "35":10,
                                      "36":10,
                                      "37":10,
                                      "38":10,
                                      "39":10,
                                      "40":10,
                                      "41":10,
                                      "42":10,
                                      "43":10,
                                      "44":10,
                                      "totalPoints":0,

                                    });
                                    DocumentSnapshot doc = await usersRef.doc(ser.user.uid).get();
                                    currentUser = Users.fromDocument(doc);

                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage(
                                              userid: ser.user.uid,
                                              auth: true,
                                            )),
                                            (_) => false );

                                    }).catchError((error){
                                      loging =  false;

                                      Fluttertoast.showToast(
                                          msg: error.message, timeInSecForIos: 4,gravity: ToastGravity.TOP);


                                    });
                                    loging = false;

                                  } on FirebaseAuthException catch(error){
                                    loging = false;

                                    Fluttertoast.showToast(
                                        msg: error.message, timeInSecForIos: 4,gravity: ToastGravity.TOP);


                                  }



                                  //     .then((result) => {
                                  //   Navigator.pushAndRemoveUntil(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => HomePage(
                                  //             title:
                                  //             firstNameInputController
                                  //                 .text +
                                  //                 "'s Tasks",
                                  //             uid: currentUser.uid,
                                  //           )),
                                  //           (_) => false),
                                  //   firstNameInputController.clear(),
                                  //   lastNameInputController.clear(),
                                  //   emailInputController.clear(),
                                  //   pwdInputController.clear(),
                                  //   confirmPwdInputController.clear()
                                  // })
                                  //     .catchError((err) => print(err)))
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Error",style: TextStyle(color:Colors.black),),
                                          content: Text("The passwords do not match",style: TextStyle(color:Colors.black),),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("Close",style: TextStyle(color:Colors.black),),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
                                }
                              }
                              else {          _registerFormKey.currentState.validate()? Container():
                              Fluttertoast.showToast(
                                  msg: "fill the required fields", timeInSecForIos: 4,gravity: ToastGravity.TOP);}
                            },
                          ),

                          Text("Or",  style: TextStyle(color:Colors.black),),
                          GoogleSignInButton(onPressed:(){signInWithGoogle();},text: "Continue with google",),


                          Text("Already have an account?",style: TextStyle(color:Colors.black),),
                          TextButton(
                            child: Text("Login here!",style: TextStyle(color:Colors.black),),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    )))));
  }
}