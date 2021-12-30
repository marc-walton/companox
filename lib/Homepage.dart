import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companox/Models/Questions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:companox/Authenticate/register.dart';
import 'package:companox/Authenticate/login.dart';
import 'package:bottom_bar/bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_splash_screen/curved_splash_screen.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:companox/Models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    loginuser();

    // Detects when user signed in
    // googleSignIn.onCurrentUserChanged.listen((account) {
    //   handleSignIn(account);
    // }, onError: (err) {
    //   print('Error signing in: $err');
    // });
    // // Reauthenticate user when app is opened
    // googleSignIn.signInSilently(suppressErrors: false).then((account) {
    //   handleSignIn(account);
    // }).catchError((err) {
    //   print('Error signing in: $err');
    // });
    //
  }
  @override

  @override

  logO() async {
    // await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    // Get.offAll(Homepage());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Homepage(
              auth: false,
            )),
            (_) => false );
    Fluttertoast.showToast(
        msg: "You have been banned. Contact us at fashure.business@gmail.com ", timeInSecForIos: 4);
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
  }

  loginuser()async{
    DocumentSnapshot doc = await usersRef.doc(widget.userid).get();
    currentUser = Users.fromDocument(doc);
  
      // myPrefs = await SharedPreferences.getInstance();
      // await myPrefs.setString('id', currentUser.id);
      // await myPrefs.setString('displayName', currentUser.displayName);
      // await myPrefs.setString('photoUrl', currentUser.photoUrl);
      // myPrefs = await SharedPreferences.getInstance();
      // idd = myPrefs.getString('id') ?? '';
      // print(',jbkbhn$idd');
      if (Platform.isIOS) getiOSPermission();

      _firebaseMessaging.getToken().then((token) {
        print("Firebase Messaging Token: $token\n");
        usersRef
            .doc(widget.userid)
            .update({"androidNotificationToken": token});
      });

      _firebaseMessaging.configure(
        // onLaunch: (Map<String, dynamic> message) async {},
        // onResume: (Map<String, dynamic> message) async {},
        onMessage: (Map<String, dynamic> message) async {
          // print("on message: $message\n");
          final String recipientId = message['data']['recipient'];
          final String body = message['notification']['body'];
          if (recipientId == widget.userid) {
            // print("Notification shown!");
            SnackBar snackBar = SnackBar(
                content: Text(
                  body,
                  overflow: TextOverflow.ellipsis,
                ));
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }
          // print("Notification NOT shown");
        },
      );
      WidgetsBinding.instance.addObserver(this);


    }
 



  configurePushNotifications() {
    final GoogleSignInAccount user = googleSignIn.currentUser;
    if (Platform.isIOS) getiOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print("Firebase Messaging Token: $token\n");
      usersRef
          .doc(user.id)
          .update({"androidNotificationToken": token});
    });

    _firebaseMessaging.configure(
      // onLaunch: (Map<String, dynamic> message) async {},
      // onResume: (Map<String, dynamic> message) async {},
      onMessage: (Map<String, dynamic> message) async {
        // print("on message: $message\n");
        final String recipientId = message['data']['recipient'];
        final String body = message['notification']['body'];
        if (recipientId == user.id) {
          // print("Notification shown!");
          SnackBar snackBar = SnackBar(
              content: Text(
                body,
                overflow: TextOverflow.ellipsis,
              ));
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
        // print("Notification NOT shown");
      },
    );
  }

  getiOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(alert: true, badge: true, sound: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      // print("Settings registered: $settings");
    });
  }


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

  logout() {
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
  }
//       Container(
// child:ElevatedButton(child: Text("Logout"),onPressed: (){
//   logout();
//   Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//           builder: (context) => Homepage(
//             auth: false,
//           )),
//           (_) => false );
  // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
// },),
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


  buildAuthScreen() {

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
drawer: Drawer(),
        body:
         currentUser.answered?Container() :Container(child: Questions())

        // bottomNavigationBar:
        // BottomBar(
        //   backgroundColor: Colors.black,
        //   selectedIndex: pageIndex,
        //   onTap: (int index) {
        //     pageController.jumpToPage(index);
        //     setState(() => pageIndex = index);
        //   },
        //   items: <BottomBarItem>[
        //     BottomBarItem(
        //       icon: Icon(Icons.weekend),
        //       title: Text('Home',style: TextStyle(color: Colors.white),),
        //       activeColor: Colors.white,
        //       inactiveColor: Colors.grey,
        //
        //     ),
        //     BottomBarItem(
        //       icon:    Icon(Icons.store,),
        //
        //       title: Text('Shop',style: TextStyle(color: Colors.white),),
        //       activeColor: Colors.white,
        //       inactiveColor: Colors.grey,
        //     ), BottomBarItem(
        //       icon: Icon(FontAwesomeIcons.swatchbook),
        //       title: Text('Freelancers',style: TextStyle(color: Colors.white),),
        //       activeColor: Colors.white,
        //       inactiveColor: Colors.grey,
        //     ),
        //     BottomBarItem(
        //       icon:Icon(Icons.play_arrow),
        //       title: Text('FashureTV',style: TextStyle(color: Colors.white),),
        //       activeColor: Colors.white,
        //       inactiveColor: Colors.grey,
        //     ),
        //     BottomBarItem(
        //       icon:      FittedBox(
        //         child: Row(
        //           children: [
        //
        //             currentUser == null?  Container(
        //
        //             ):badgescount(),
        //             Icon(Icons.inbox,),
        //           ],
        //         ),
        //       ),
        //
        //       title: Text('Settings',style: TextStyle(color: Colors.white),),
        //       activeColor: Colors.white,
        //       inactiveColor: Colors.grey,
        //
        //     ),
        //   ],
        // ),


      ),
    );
//    return RaisedButton(
//      child: Text('Log out'),
//      onPressed: logout,
//    );
  }

  Scaffold  buildUnAuthScreen(parentContext) {
    final Orientation orientation = MediaQuery.of(context).orientation;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        // decoration: BoxDecoration(
        //
        //     gradient: fabGradient
        // ) ,
        // alignment: Alignment.center,
        child:
        CurvedSplashScreen(
          bottomSheetColor: Colors.black,
          backText:"",
          skipText: "",
          screensLength: splashContent.length,
          screenBuilder: (index) {
            return SplashContent(
              title: splashContent[index]["title"],
              image: splashContent[index]["image"],
              text: splashContent[index]["text"],
            );
          },
        ),),


      bottomNavigationBar: Container(
        color: Colors.black,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [Container(
                width:150.0,
                child: FloatingActionButton.extended(
                  elevation: 10.0,

                  heroTag:'in',
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),

                  backgroundColor: Colors.black,
                  onPressed: ()=>  Navigator.push(
                    parentContext,
                    MaterialPageRoute(
                        builder: (context) => LoginPage(

                        )),
                  ),
                  label: Text('Sign in',style:TextStyle(color: Colors.white) ,),
                ),
              ),

                Container(
                  width:150.0,

                  child: FloatingActionButton.extended(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    heroTag:'up',
                    backgroundColor: Colors.black,
                    onPressed: ()=>Navigator.push(
                      parentContext,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage(

                          )),
                    ),
                    label: Text('Sign up',style:TextStyle(color: Colors.white) ,),
                  ),
                ),],
            ),
          ),
        ),
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