import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companox/Models/Questions.dart';
import 'package:companox/Screens/Task.dart';
import 'package:companox/Authenticate/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:companox/Models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';


final GoogleSignIn googleSignIn = GoogleSignIn();


final Reference storageRef = FirebaseStorage.instance.ref();
final usersRef = FirebaseFirestore.instance.collection('users');

final DateTime timestamp = DateTime.now().toUtc();
Users currentUser;

class Homepage extends StatefulWidget {
  final userid;
  final photo;

  final bool auth;

  const Homepage({Key key, this.userid, this.photo,this.auth}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();


}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {


  buildAuthScreen() {

    return SafeArea(
      child: Scaffold(

        body:
         currentUser.answered? Container(color:Colors.grey.shade200,child: Tasks()) :Container(child: Questions())



      ),
    );

  }

  Scaffold  buildUnAuthScreen(parentContext) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        child:
        LoginPage(),
       ),
    );


  }
  @override
  Widget build(BuildContext context) {
    return widget.auth? buildAuthScreen() : buildUnAuthScreen(context);





  }
}
