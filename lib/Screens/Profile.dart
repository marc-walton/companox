import 'package:cached_network_image/cached_network_image.dart';
import 'package:companox/Homepage.dart';
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  assessmentScore(){
    if(   currentUser.totalPoints >90 ){
      return
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("You project severe signs of Anxiety & Depression",style:TextStyle(fontSize:MediaQuery.of(context).size.width/10)),
        );

    }
    else if(   currentUser.totalPoints >75&&currentUser.totalPoints <=90 ){
      return
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("You project signs of Anxiety & Depression ",style:TextStyle(fontSize:MediaQuery.of(context).size.width/10)),
        );

    }
    else if(   currentUser.totalPoints >=45&&currentUser.totalPoints <=75){
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
    if(   currentUser.Ques28Points == 6 ){
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
    else if(   currentUser.Ques28Points >=3 ){
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
    else if(   currentUser.Ques28Points >=3 ){
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text("Profile",style: TextStyle(fontSize: MediaQuery.of(context).size.width/15,color: Colors.black,
                shadows:[
                  Shadow(  offset:Offset(1.0,2.0),
                      blurRadius: 3.0,
                      color: Colors.black26
                  )
                ] ),),
          ],
        ),
        leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

          Navigator.pop(context);
        },),

      ),

      body: SingleChildScrollView(child:
      Column(children: [

        ListTile(leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(currentUser.photoUrl),),
        title: Text(currentUser.displayName),

        ),
        SizedBox(height:20.0),
        Row(
          children: [
            Text("Your Assessment",style:TextStyle(fontSize: MediaQuery.of(context).size.width/15)),
          ],
        ),
        SizedBox(height:30),
        assessmentScore(),
        currentUser.Ques28?q28Score():Container(),
      ],)),
    );
  }
}
