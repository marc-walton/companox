import 'package:companox/Authenticate/login.dart';
import 'package:companox/Homepage.dart';
import 'package:companox/Models/Questions.dart';
import 'package:companox/Screens/Help.dart';
import 'package:companox/Screens/Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    logout() {
      FirebaseAuth.instance.signOut();
      googleSignIn.signOut();
      Get.offAll(()=>LoginPage());
    }
    retakeTest()  {
      usersRef.doc(currentUser.id).update({
        "answered":false,
        "next":1,
        "Q28":false,
      });
    }
    return Scaffold(
      endDrawer: Drawer(child:  Container(
        child: Column(children: [
          ListTile(
            leading: CircleAvatar(child:Image.asset('assests/img/appIcon.png'),),
            title: Text("Companox"),
            trailing:GestureDetector(onTap:()=>Navigator.pop(context),child: Icon(Icons.close_outlined)) ,),
          InkWell(child: ListTile(title: Text("Get professional help",style:TextStyle(fontSize:MediaQuery.of(context).size.width/18, ))),onTap:()=> Get.to(()=>Help()),),
          InkWell(child: ListTile(title: Text("Take another test",style:TextStyle(fontSize:MediaQuery.of(context).size.width/18,)),onTap: () =>{
            retakeTest(),
            Navigator.pop(context),
            Get.offAll(()=>Questions()),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Card(child: Container(
                  height: MediaQuery.of(context).size.height/2.5,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Go for a 1KM run or a 30 minutes walk",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                        ),

                        Image.asset("assests/img/sprinting.png",  height: MediaQuery.of(context).size.height/4.5,
                          width: double.infinity,),
                        TextButton(child: Text("Turn on foot step tracker"),onPressed: (){},)

                      ],
                    ))
                  ,),
              ),
            ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Card(child: Container(
                  height: MediaQuery.of(context).size.height/2.5,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Do a breathing exercise",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                        ),
                        Image.asset("assests/img/meditating.png",  height: MediaQuery.of(context).size.height/4.5,
                          width: double.infinity,),
                        TextButton(child: Text("Exercise along with the app assistant"),onPressed: (){},),

                      ],
                    ))
                  ,),
              ),
            ),
        Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Card(child: Container(
                  height: MediaQuery.of(context).size.height/2.5,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Listen to different genres of music",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                        ),
                        Image.asset("assests/img/dancing.png",  height: MediaQuery.of(context).size.height/4.5,
                          width: double.infinity,),
                        TextButton(child: Text("Listen to the playlist curated for you!"),onPressed: (){},),

                      ],
                    ))
                  ,),
              ),
            ),
   Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Card(child: Container(
                  height: MediaQuery.of(context).size.height/2.5,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Try spending more quality time with your friends",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                        ),
                        Image.asset("assests/img/selfie.png",  height: MediaQuery.of(context).size.height/4.5,
                          width: double.infinity,),
                        TextButton(child: Text("Meet people with similar condition as yours"),onPressed: (){},),

                      ],
                    ))
                  ,),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
