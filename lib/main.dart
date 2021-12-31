import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companox/Homepage.dart';
import 'package:companox/Models/user.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FaShow());
}
class FaShow extends StatefulWidget {
  @override
  _FaShowState createState() => _FaShowState();
}

class _FaShowState extends State<FaShow> {
  bool isAuth = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  dynamic user;
  dynamic photo;

  @override
  void initState() {
    super.initState();

    auth();



  }

  auth() async {

    DocumentSnapshot doc;
    FirebaseAuth.instance
        .userChanges()
        .listen((users) async => {
      if (users == null)
        {
          setState(() {
            isAuth = false;
          }),
          // Navigator.pushReplacementNamed(context, "/login")
        }
      else
        {
          user= users.uid,
          photo= users.photoURL,

          setState(() async {
            isAuth = true;

          }),
           doc = await usersRef.doc(users.uid).get(),
          currentUser = Users.fromDocument(doc),
        }
    });
  }

  @override
  Widget build(BuildContext context) {

    return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home:
        AnimatedSplashScreen(
            duration: 2000,
            splash:
Container(height:900,width:900,child: Image.asset('assests/img/COMPANOX.png',height:900,width:900,fit: BoxFit.fitHeight,)),
            nextScreen: Homepage(userid: user,photo: photo,auth: isAuth,),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.black
        ),
      );

  }


}

