import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companox/Models/Questions.dart';
import 'package:companox/Screens/Help.dart';
import 'package:companox/Screens/Profile.dart';
import 'package:companox/Screens/Task.dart';
import 'package:companox/Authenticate/register.dart';
import 'package:companox/Authenticate/login.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_splash_screen/curved_splash_screen.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:companox/Models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
  Timer _timerLink;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int data;
  int serdata;
  // String reviewId = Uuid().v4();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool isAuth ;
  bool h = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User loggedInUser;

  PageController pageController;
  int pageIndex = 0;
  SharedPreferences myPrefs;
  String idd;
  String username;

  @override
  void initState() {
    super.initState();

    pageController = PageController();

  }
  @override



 



  @override
  void dispose() {
    pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    if (_timerLink != null) {
      _timerLink.cancel();
    }    super.dispose();
  }

  login() {

    googleSignIn.signIn();
  }


  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 001),
      curve: Curves.easeInOut,
    );
  }
  logout() {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
    Get.offAll(()=>LoginPage());
  }
retakeTest() async {
  usersRef.doc(currentUser.id).update({
    "answered":false,
    "next":1,
    "Q28":false,
  });
 DocumentSnapshot doc = await usersRef.doc(currentUser.id).get();
  currentUser = Users.fromDocument(doc);
}
  buildAuthScreen() {

    return SafeArea(
      child: Scaffold(
endDrawer: Drawer(child:  Container(
  child: Column(children: [
    ListTile(trailing:GestureDetector(onTap:()=>Navigator.pop(context),child: Icon(Icons.close_outlined)) ,),
    InkWell(child: ListTile(title: Text("Get professional help",style:TextStyle(fontSize:MediaQuery.of(context).size.width/18, ))),onTap:()=> Get.to(()=>Help()),),
    InkWell(child: ListTile(title: Text("Take another test",style:TextStyle(fontSize:MediaQuery.of(context).size.width/18,)),onTap: (){
      retakeTest();
      Navigator.pop(context);
      setState(() { });

    },),),
    InkWell(child: ListTile(title: Text("My profile",style:TextStyle(fontSize:MediaQuery.of(context).size.width/18,)),onTap:()=> Get.to(()=>Profile()),)),
    InkWell(child: ListTile(title: Text("Logout",style:TextStyle(fontSize:MediaQuery.of(context).size.width/18,)),onTap:()=> logout(),)),

  ],),
),),
appBar: AppBar(elevation: 0.0,
    backgroundColor: Colors.white,
iconTheme: IconThemeData(color: Colors.black) ,
title: Row(
  children: [
        Text("Tasks",style: TextStyle(fontSize: MediaQuery.of(context).size.height/15,color: Colors.black,
            shadows:[
            Shadow(  offset:Offset(1.0,2.0),
              blurRadius: 3.0,
              color: Colors.black26
            )
            ] ),),
  ],
),),
        body:
         currentUser.answered? Container(color:Colors.grey.shade200,child: Tasks()) :Container(child: Questions())



      ),
    );
//    return RaisedButton(
//      child: Text('Log out'),
//      onPressed: logout,
//    );
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
class button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GoogleSignInButton(
      // onPressed: login,
      darkMode: true, // default: false
    );
  }
}

class SplashContent extends StatelessWidget {
  final String title;
  final String text;
  final String image;

  const SplashContent({
    Key key,
    @required this.title,
    @required this.text,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Container(
            height: 200,
            child: Image.asset(image),
          ),
          SizedBox(height: 60),
          Text(
            title,
            style: TextStyle(fontFamily: 'MajorMonoDisplay',
              color: Colors.black,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
            ),
          )
        ],
      ),
    );
  }
}


final splashContent = [
  {
    "title": "DESIGN",
    "text": "THIS IS A SPLASH SCREEN",
    "image": "assets/img/design.png",
  },
  {
    "title": "CREATE CONTENT",
    "text": "Our app lets you to create a content and display it to the world",
    "image": "assets/img/create content.png",
  },
  {
    "title": "SELL",
    "text": "Sell your products and get full satisfaction from your customer",
    "image": "assets/img/sell.png"
  },
  {
    "title": "FASHION SHOW",
    "text": "Catch up with our live fashion show on LIVE TV",
    "image": "assets/img/fashion show.png"
  },

  {
    "title": "INFLUENCE",
    "text": "A fashion that does not reach the streets is not a fashion",
    "image": "assets/img/influence.png"
  },
  {
    "title": "SHOP",
    "text": "Our app connects worldwide designers just for you",
    "image": "assets/img/shop.png"
  },

];