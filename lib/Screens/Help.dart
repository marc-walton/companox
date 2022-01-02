import 'package:flutter/material.dart';
class Help extends StatefulWidget {

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
        title: Row(
          children: [
            Text("Professional Help",style: TextStyle(fontSize: MediaQuery.of(context).size.width/15,color: Colors.black,
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
      body: SingleChildScrollView(child:Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Card(child: Container(
                width: double.infinity,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Dr.Marlina",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                  ),
                  leading:CircleAvatar(
                    child: Image.asset("assests/img/doc1.jpg",  height: MediaQuery.of(context).size.height/3.5,
                    ),
                  ),
                  subtitle: Text("Psychiatrist",style:TextStyle(fontSize: MediaQuery.of(context).size.width/25)),
                ))
              ,),
          ),
        ),
  Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Card(child: Container(
                width: double.infinity,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Dr.Margreat",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                  ),
                  leading:CircleAvatar(
                    child: Image.asset("assests/img/doc2.jpg",  height: MediaQuery.of(context).size.height/3.5,
                    ),
                  ),
                  subtitle: Text("Therapist",style:TextStyle(fontSize: MediaQuery.of(context).size.width/25)),
                ))
              ,),
          ),
        ),

      ],)),
    );
  }
}
