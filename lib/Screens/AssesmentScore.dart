import 'package:alert_dialog/alert_dialog.dart';
import 'package:companox/Homepage.dart';
import 'package:companox/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssessmentScore extends StatefulWidget {

  @override
  _AssessmentScoreState createState() => _AssessmentScoreState();
}

class _AssessmentScoreState extends State<AssessmentScore> {
assessmentScore(){
  if(   currentUser.totalPoints >90 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("You project severe signs of Anxiety & Depression",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),
          ],
        ),
      );

  }
  else if(   currentUser.totalPoints >75&&currentUser.totalPoints <=90 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("You project signs of Anxiety & Depression ",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),
          ],
        ),
      );

  }
  else if(   currentUser.totalPoints >=45&&currentUser.totalPoints <=75){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("You project mild sign of Depression",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),
          ],
        ),
      );

  }
 else {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text("You seem to be mentally fit!",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),
          ],
        ),
      );

  }

}
q28Score(){
  if(   currentUser.Ques28Points == 6 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             Text("And",style:TextStyle(fontSize: MediaQuery.of(context).size.height/18)),
             Text("PTSD positive",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),

          ],
        ),
      );

  }
 else if(   currentUser.Ques28Points >=3 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
          child: Column(
          children: [
            Text("And",style:TextStyle(fontSize: MediaQuery.of(context).size.height/18)),
            Text("shows some sign of PTSD",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),
          ],
        ),
      );

  }
 else if(   currentUser.Ques28Points >=3 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("And",style:TextStyle(fontSize: MediaQuery.of(context).size.height/18)),
            Text("PTSD negative",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),          ],
        ),
      );

  }

}
  @override
  Widget build(BuildContext context) {
    return       Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions:[
            ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700), child:Text("Next"),onPressed: () async {

            DocumentSnapshot  doc = await usersRef.doc(currentUser.id).get();
              currentUser = Users.fromDocument(doc);
              Get.offAll(()=>Homepage(
              userid:currentUser.id,
              auth: true,
              ));
            },),
          ]),
      body: Container(
        color: Colors.white,

        child: ListView(

          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/4),
assessmentScore(),
            currentUser.Ques28?q28Score():Container(),
            SizedBox(height:MediaQuery.of(context).size.height/2),
            ElevatedButton.icon(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700), label:Text("Continue"),onPressed: () async {

              DocumentSnapshot  doc = await usersRef.doc(currentUser.id).get();
              currentUser = Users.fromDocument(doc);
              Get.offAll(()=>Homepage(
                userid:currentUser.id,
                auth: true,
              ));
            }, icon: Icon(Icons.arrow_forward),),
          ],
        ),
      ),
    );

  }
}
