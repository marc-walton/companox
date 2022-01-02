import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Card(child: Container(
                height: MediaQuery.of(context).size.height/3,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Go for a 1KM run or a 30 minutes walk",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                      ),

                      Image.asset("assests/img/sprinting.png",  height: MediaQuery.of(context).size.height/4.5,
                        width: double.infinity,),
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
                height: MediaQuery.of(context).size.height/3,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Do a breathing exercise",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                      ),
                      Image.asset("assests/img/meditating.png",  height: MediaQuery.of(context).size.height/4.5,
                        width: double.infinity,)

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
                height: MediaQuery.of(context).size.height/3,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Listen to different genres of music",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                      ),
                      Image.asset("assests/img/dancing.png",  height: MediaQuery.of(context).size.height/4.5,
                        width: double.infinity,),
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
                height: MediaQuery.of(context).size.height/3,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Try spending more quality time with your friends",style:TextStyle(fontSize: MediaQuery.of(context).size.width/18)),
                      ),
                      Image.asset("assests/img/selfie.png",  height: MediaQuery.of(context).size.height/4.5,
                        width: double.infinity,),
                    ],
                  ))
                ,),
            ),
          ),

        ],
      ),
    );
  }
}
