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
final int totalPoints;
final int q28points;

  const AssessmentScore({Key key, this.totalPoints, this.q28points}) : super(key: key);
  @override
  _AssessmentScoreState createState() => _AssessmentScoreState();
}

class _AssessmentScoreState extends State<AssessmentScore> {
assessmentScore(){
  if(   widget.totalPoints >90 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Text("You project severe signs of Anxiety & Depression",style:TextStyle(fontSize:MediaQuery.of(context).size.width/10)),

      );

  }
  else if(   widget.totalPoints >75&&widget.totalPoints <=90 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("You project signs of Anxiety & Depression ",style:TextStyle(fontSize:MediaQuery.of(context).size.width/10)),
      );

  }
  else if(   widget.totalPoints >=45&&widget.totalPoints <=75){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("You project mild sign of Depression",style:TextStyle(fontSize:MediaQuery.of(context).size.width/10)),
      );

  }
 else {
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("You seem to be mentally fit!",style:TextStyle(fontSize:MediaQuery.of(context).size.width/10)),
      );

  }

}
q28Score(){
  if(   widget.q28points == 6 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("And",style:TextStyle(fontSize: MediaQuery.of(context).size.width/8,color: Colors.green)),
             Text("PTSD positive",style:TextStyle(fontSize:MediaQuery.of(context).size.width/10)),

          ],
        ),
      );

  }
 else if(   widget.q28points >=3 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
          child: Column(
          children: [
            Text("And",style:TextStyle(fontSize: MediaQuery.of(context).size.width/8,color: Colors.green)),
            Text("shows some sign of PTSD",style:TextStyle(fontSize:MediaQuery.of(context).size.width/10)),
          ],
        ),
      );

  }
 else if(   widget.q28points >=3 ){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("And",style:TextStyle(fontSize: MediaQuery.of(context).size.width/8,color: Colors.green)),
            Text("PTSD negative",style:TextStyle(fontSize:MediaQuery.of(context).size.width/10)),          ],
        ),
      );

  }

}
  @override
  Widget build(BuildContext context) {
    return       Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(

          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/5),
assessmentScore(),
            currentUser.Ques28?q28Score():Container(),
            SizedBox(height:MediaQuery.of(context).size.height/30),
            ElevatedButton.icon(style:ElevatedButton.styleFrom(
                primary:Colors.white), label:Text("Continue",style: TextStyle(color:Colors.green),),onPressed: () async {
              usersRef.doc(currentUser.id).update({
                "answered":true,
                "next":2,

              });
              DocumentSnapshot  doc = await usersRef.doc(currentUser.id).get();
              currentUser = Users.fromDocument(doc);
              Get.offAll(()=>Homepage(
                userid:currentUser.id,
                auth: true,
              ));
            }, icon: Icon(Icons.arrow_forward,color: Colors.green,),),
          ],
        ),
      ),
    );

  }
}
