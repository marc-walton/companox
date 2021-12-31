import 'package:alert_dialog/alert_dialog.dart';
import 'package:companox/Authenticate/register.dart';
import 'package:companox/Homepage.dart';
import 'package:companox/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
class RIKeys {
  static final riKey1 = const Key('__RIKEY1__');
  static final riKey2 = const Key('__RIKEY2__');
  static final riKey3 = const Key('__RIKEY3__');
}
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>(debugLabel: '_LoginFormState');
  GlobalKey<FormState> _forgotFormKey = GlobalKey<FormState>(debugLabel: '_forgotFormState');
  bool _passwordVisible = false;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  String accountErrorMessage;
  bool loging =  false;
// Late FToast Ftoast;
  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
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
/// For authenticating user using Google Sign In
/// with Firebase Authentication API.

Future<User> signInWithGoogle() async {
loging = true;
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
        "answered":false,
        "next": 0,
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
        "Q28-32":false,
        "totalPoints":0,

      });

      doc = await usersRef.doc(user.uid).get();
  }
  print("this is after the google login");
  currentUser = Users.fromDocument(doc);
  print(currentUser.displayName);
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
  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }
  Future<void> resetPassword({String email,parentContext}) async {
    return
      showModalBottomSheet(
          context: parentContext,
          builder: (BuildContext context) {
            return
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(

                    child:        Form(
                      key: _forgotFormKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(color:Colors.black),
                            decoration: InputDecoration(
                              labelStyle:  TextStyle(color:Colors.black),
                              hintStyle:  TextStyle(color:Colors.black),
                              labelText: 'Email', ),
                            controller: emailInputController,
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation : 0.1,

                              primary:  Colors.white.withOpacity(0.1), // background
                            ),
                            child:
                            Text('Send mail',style: TextStyle(color: Colors.blue,
                            ),),

                            onPressed: () async {
                              if (_loginFormKey.currentState.validate()) {
                                await  FirebaseAuth.instance.sendPasswordResetEmail(email: emailInputController.text);

                              }
                              Get.back();
                              alert(
                                parentContext,
                                content:
                                Text('Password reset has been sent to your Email',
                                  style: TextStyle(color: Colors.blue,
                                  ),),

                                textOK: Text('Ok'),
                              );
                            },
                          ),

                        ],
                      ),
                    )

                ),
              );

          }
      );
  }
  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: loging,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Login", style: TextStyle(color:Colors.white),),
          ),
          body: Container(

              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(color:Colors.black),
                          decoration: InputDecoration(
                              labelStyle:  TextStyle(color:Colors.black),
                              hintStyle:  TextStyle(color:Colors.black),
                              labelText: 'Email', hintText: "john.doe@gmail.com"),
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                        TextFormField(
                          obscureText: !_passwordVisible,//This will obscure text dynamically

                          style: TextStyle(color:Colors.black),
                          decoration: InputDecoration(
                            labelStyle:  TextStyle(color:Colors.black),
                            hintStyle:  TextStyle(color:Colors.black),
                            labelText: 'Password',
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
                            ),),
                          controller: pwdInputController,
                          validator: pwdValidator,
                        ),
                        TextButton(
                          child: Text("Forgot Password?",  style: TextStyle(color:Colors.black),),
                          onPressed: () {
                            resetPassword(parentContext: context,email: emailInputController.text??"")    ;                    },
                        ),
                        ElevatedButton(

                          child: Text("Login"),
                          style: ElevatedButton.styleFrom(
                            elevation : 0.1,

                            primary:  Colors.black, // background
                          ),
                          onPressed: () {
                            if (_loginFormKey.currentState.validate()) {
                              try{
                                loging =  true;

                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                    email: emailInputController.text,
                                    password: pwdInputController.text)
                                    .then((User) => FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(User.user.uid)
                                    .get()
                                    .then((DocumentSnapshot result)
                                async {
                                  loging =  false;
                                  DocumentSnapshot doc = await usersRef.doc(User.user.uid).get();
                                  currentUser = Users.fromDocument(doc);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Homepage(
                                            userid:User.user.uid,
                                            auth: true,
                                          )),
                                          (_) => false );
                                }

                                ).catchError((error){
                                  loging =  false;
                                  GFToast(
                                    child: Text(error.message) ,
                                    duration: Duration(milliseconds: 400),
                                    alignment: Alignment.topCenter,
                                    textStyle: TextStyle(fontSize: 16, color: GFColors.LIGHT),
                                    backgroundColor: GFColors.DARK,
                                  );
                                  Fluttertoast.showToast(
                                      msg: error.message, timeInSecForIos: 4,gravity: ToastGravity.TOP);

                                }),
                                ).catchError((error){
                                  loging =  false;

                                  Fluttertoast.showToast(
                                      msg: error.message, timeInSecForIos: 4,gravity: ToastGravity.TOP);
                                });
                              } on FirebaseAuthException catch(error){
                                loging =  false;

                                GFToast(
                                  text: '${error.message}',
                                  duration: Duration(milliseconds: 400),
                                  alignment: Alignment.topCenter,
                                  textStyle: TextStyle(fontSize: 16, color: GFColors.LIGHT),
                                  backgroundColor: GFColors.DARK,
                                );
                              }

                            }
                          },
                        ),

                        Text("Or",  style: TextStyle(color:Colors.black),),
                        GoogleSignInButton(onPressed:(){signInWithGoogle();},),
                        Text("your first time?",  style: TextStyle(color:Colors.black),),

                        TextButton(
                          child: Text("Register here!",  style: TextStyle(color:Colors.black),),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()))    ;                    },
                        )
                      ],
                    ),
                  )))),
    );
  }
}