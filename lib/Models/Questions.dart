import 'package:alert_dialog/alert_dialog.dart';
import 'package:companox/Homepage.dart';
import 'package:companox/Models/user.dart';
import 'package:companox/Screens/AssesmentScore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Questions extends StatefulWidget {

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  PageController pageController = PageController(initialPage: currentUser.next);
  int pageChanged = currentUser.next;
  bool isUploading;
  final _formKey = GlobalKey<FormState>();
  TextEditingController Age =  TextEditingController();
  List<String> selectedOption = <String>[];
int value;
  DocumentSnapshot doc;
  int assessment;
  int q28Score;
  intro(){
    return
    Scaffold(
      appBar: AppBar(
          elevation: 0.0,
 backgroundColor: Colors.white,
          actions:[
            ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700), child:Text("Next"),onPressed: (){
          usersRef.doc(currentUser.id).update({
          "next":1,
        });
          selectedOption = <String>[];
              selectedOption = <String>[];
              pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
},),
      ]),
      body: Container(
        color: Colors.white,

        child: ListView(

            children: <Widget>[
              SizedBox(height:MediaQuery.of(context).size.height/4),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Take assessment",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),
                ),
              SizedBox(height:MediaQuery.of(context).size.height/2),

            ],
        ),
      ),
    );

  }

  question1(){

    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            actions:[
               ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700),child:Text("Next"),onPressed: (){
                if(_formKey.currentState.validate()) {
                  usersRef.doc(currentUser.id).update({
                    "age":Age,
                    "next":2,
                  });
                  selectedOption = <String>[];
              pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
}
                else{
                  return
                    alert(
                      context,
                      // title: Text('Coming Soon'),
                      content:Text("Fill the required the fields",
                      ),

                      textOK: Text("Ok",
                      ),

                    );
                }

              },),
            ]),

        body: Container(
          color:Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height:MediaQuery.of(context).size.height/4),
                Text("How old are you?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/8)),
              Form(
                key: _formKey,
                child:
                Container(
                  margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0,8.0),
                  child: TextFormField(
                    style:TextStyle(color: Colors.black),

                    keyboardType: TextInputType.number,
                    maxLines: null,
                    controller: Age,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),

                      labelText: 'Age',labelStyle: TextStyle(color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                    validator: (text) {
                      if ( text.isEmpty) {
                        return 'Age is empty';
                      }
                      return null;
                    },
                  ),
                ),
              ),





              ],
            ),
          ),
        ),
      );

  }
    question2(){
    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
               ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700),child:Text("Next"),onPressed: ()=>
              selectedOption.isEmpty?     Fluttertoast.showToast(
                  msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                usersRef.doc(currentUser.id).update({
                  "2":value,
                  "next":3,
                }),
                value = null,
                selectedOption = <String>[],
                pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut)   },),
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Have you ever been diagnosed with a mental health condition by a professional (doctor, therapist, etc.)?"
                    ,style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),
GFRadioListTile(titleText: "YES",
  value: 3,
  groupValue: value,
  onChanged:(val){setState(() {
    value = val;
    selectedOption =  <String>[];
    selectedOption.add("1");
  });
  },
),
GFRadioListTile(titleText: "NO",
  value: 0,
    groupValue: value,
    onChanged:(val){setState(() {
      value = val;
      selectedOption =  <String>[];
      selectedOption.add("2");
    });
    },

),



            ],
          ),
        ),
      );

  }
    question3(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
               ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700),child:Text("Next"),onPressed: ()=>
              selectedOption.isEmpty?     Fluttertoast.showToast(
                  msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                usersRef.doc(currentUser.id).update({
                  "3":value,
                  "next":4,
                }),
                                selectedOption = <String>[],
value = null,
                pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
},),
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Have you ever received treatment/support for a mental health problem?"
                    ,style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),
              GFRadioListTile(titleText: "YES",
  value: 3,
  groupValue: value,
  onChanged:(val){setState(() {
    value = val;
    selectedOption =  <String>[];
    selectedOption.add("1");
  });
  },
),
GFRadioListTile(titleText: "NO",
  value: 0,
    groupValue: value,
    onChanged:(val){setState(() {
      value = val;
      selectedOption =  <String>[];
      selectedOption.add("2");
    });
    },

),


            ],
          ),
        ),
      );

  }
   question4(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
              selectedOption.isEmpty?     Fluttertoast.showToast(
                  msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                usersRef.doc(currentUser.id).update({
                  "4":value,
                  "next":5,
                }),
                                selectedOption = <String>[],
value = null,
                pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
},),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Over the last 2 weeks, how often have you been bothered by any of the following problems?\nExperienced Headache?"
                  ,style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
            ),
SizedBox(height:8),
            GFRadioListTile(titleText: "NOT AT ALL",
              value: 0,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("1");
              });
              },
            ),
            GFRadioListTile(titleText: "SEVERAL DAYS",
              value: 1,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("2");
              });
              },

            ),
            GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
              value: 2,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("3");
              });
              },

            ),
            GFRadioListTile(titleText: "ALMOST EVERYDAY",
              value: 3,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("4");
              });
              },

            ),


          ],
        ),
      );

  }
   question5(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
               ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700),child:Text("Next"),onPressed: ()=>
              selectedOption.isEmpty?     Fluttertoast.showToast(
                  msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                usersRef.doc(currentUser.id).update({
                  "5":value,
                  "next":6,
                }),
                                selectedOption = <String>[],
value = null,
                pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
},),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Experienced Dizziness?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
            ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "SEVERAL DAYS",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "ALMOST EVERYDAY",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),

          ],
        ),
      );

  }
   question6(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                  primary:Colors.green.shade700),child:Text("Next"),onPressed: ()=>
              selectedOption.isEmpty?     Fluttertoast.showToast(
                  msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                usersRef.doc(currentUser.id).update({
                  "6":value,
                  "next":7,
                }),
                                selectedOption = <String>[],
value = null,
                pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
},),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Experienced pain in heart or chest?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
            ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                  value: 0,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("1");
                  });
                  },
                ),
                GFRadioListTile(titleText: "SEVERAL DAYS",
                  value: 1,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("2");
                  });
                  },

                ),
                GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                  value: 2,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("3");
                  });
                  },

                ),
                GFRadioListTile(titleText: "ALMOST EVERYDAY",
                  value: 3,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("4");
                  });
                  },

                ),

            ],
          ),
      );

  }
  question7(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                  primary:Colors.green.shade700),child:Text("Next"),onPressed: ()=>
              selectedOption.isEmpty?     Fluttertoast.showToast(
                  msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                usersRef.doc(currentUser.id).update({
                  "7":value,
                  "next":8,
                }),
                                selectedOption = <String>[],
value = null,
                pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
},),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Experienced trouble breathing?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                  value: 0,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("1");
                  });
                  },
                ),
                GFRadioListTile(titleText: "SEVERAL DAYS",
                  value: 1,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("2");
                  });
                  },

                ),
                GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                  value: 2,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("3");
                  });
                  },

                ),
                GFRadioListTile(titleText: "ALMOST EVERYDAY",
                  value: 3,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("4");
                  });
                  },

                ),

            ],
          ),
      );

  }
 question8(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "8":value,
                    "next":9,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Experienced numbness?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),
GFRadioListTile(titleText: "NOT AT ALL",
                  value: 0,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("1");
                  });
                  },
                ),
                GFRadioListTile(titleText: "SEVERAL DAYS",
                  value: 1,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("2");
                  });
                  },

                ),
                GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                  value: 2,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("3");
                  });
                  },

                ), 
                GFRadioListTile(titleText: "ALMOST EVERYDAY",
                  value: 3,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("4");
                  });
                  },

                ),

            ],
          ),
      );

  }
 question9(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "9":value,
                    "next":10,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Experienced dryness of mouth?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),
GFRadioListTile(titleText: "NOT AT ALL",
                  value: 0,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("1");
                  });
                  },
                ),
                GFRadioListTile(titleText: "SEVERAL DAYS",
                  value: 1,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("2");
                  });
                  },

                ),
                GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                  value: 2,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("3");
                  });
                  },

                ), 
                GFRadioListTile(titleText: "ALMOST EVERYDAY",
                  value: 3,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("4");
                  });
                  },

                ),

            ],
          ),
      );

  }
 question10(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "10":value,
                    "next":11,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Felt like there is nothing to look forward to?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                  value: 0,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("1");
                  });
                  },
                ),
                GFRadioListTile(titleText: "SEVERAL DAYS",
                  value: 1,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("2");
                  });
                  },

                ),
                GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                  value: 2,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("3");
                  });
                  },

                ), 
                GFRadioListTile(titleText: "ALMOST EVERYDAY",
                  value: 3,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("4");
                  });
                  },

                ),

            ],
          ),
      );

  }
question11(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "11":value,
                    "next":12,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Felt down hearted or blue?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),
GFRadioListTile(titleText: "NOT AT ALL",
                  value: 0,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("1");
                  });
                  },
                ),
                GFRadioListTile(titleText: "SEVERAL DAYS",
                  value: 1,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("2");
                  });
                  },

                ),
                GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                  value: 2,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("3");
                  });
                  },

                ), 
                GFRadioListTile(titleText: "ALMOST EVERYDAY",
                  value: 3,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("4");
                  });
                  },

                ),

            ],
          ),
      );

  }
question12(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "12":value,
                    "next":13,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Felt close to panic?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                  value: 0,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("1");
                  });
                  },
                ),
                GFRadioListTile(titleText: "SEVERAL DAYS",
                  value: 1,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("2");
                  });
                  },

                ),
                GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                  value: 2,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("3");
                  });
                  },

                ), 
                GFRadioListTile(titleText: "ALMOST EVERYDAY",
                  value: 3,
                  groupValue: value,
                  onChanged:(val){setState(() {
                    value = val;
                    selectedOption =  <String>[];
                    selectedOption.add("4");
                  });
                  },

                ),



            ],
          ),
      );

  }
question13(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "13":value,
                    "next":14,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Unable to be enthusiastic about things?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
  midPage_Page14(){
    return
      Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),

            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                  primary:Colors.green.shade700), child:Text("Next"),onPressed: (){
                usersRef.doc(currentUser.id).update({
                  "next":15,
                });
                selectedOption = <String>[];
                pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
              },),
            ]),
        body: Container(
          color: Colors.white,

          child: ListView(

            children: <Widget>[
              SizedBox(height:MediaQuery.of(context).size.height/4),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("TAKE A DEEP BREATHE AND EXHALE",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),
              ),
              SizedBox(height:MediaQuery.of(context).size.height/2),

            ],
          ),
        ),
      );

  }


  question14(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "14":value,
                    "next":16,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Little interest or pleasure in doing things?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question15(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "15":value,
                    "next":17,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Feeling down depressed or hopeless?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question16(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "16":value,
                    "next":18,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Trouble falling or staying asleep, or sleeping too much?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question17(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "17":value,
                    "next":19,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Feeling tired or having little energy?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question18(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "18":value,
                    "next":20,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Poor appetite or overeating?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question19(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "19":value,
                    "next":21,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Trouble concentrating on things, such as reading the newspaper or watching television?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question20(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "20":value,
                    "next":22,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Moving or speaking so slowly that other people could have noticed. Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question21(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "21":value,
                    "next":23,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Thought that you would be better off dead, or by hurting yourself?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question22(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "22":value,
                    "next":24,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Feeling anxious, nervous or on edge?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question23(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "23":value,
                    "next":25,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Not being able to stop or control worrying?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question24(){

    return      Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

            pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

          },),
          actions:[
            ElevatedButton(style:ElevatedButton.styleFrom(
              primary:Colors.green.shade700, // b
            ),
              child:Text("Next"),onPressed: ()=>
              selectedOption.isEmpty?     Fluttertoast.showToast(
                  msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                usersRef.doc(currentUser.id).update({
                  "24":value,
                  "next":26,
                }),
                selectedOption = <String>[],
                value = null,
                pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
              },),
          ]),
      body: ListView(
        children: <Widget>[
          SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Trouble relaxing?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question25(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "25":value,
                    "next":27,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Being so restless that it’s hard to sit still?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question26(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "26":value,
                    "next":28,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Becoming easily annoyed or irritable?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question27(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "27":value,
                    "next":29,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Feeling afraid as if something awful might happen?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

GFRadioListTile(titleText: "NOT AT ALL",
                    value: 0,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("1");
                    });
                    },
                  ),
                  GFRadioListTile(titleText: "SEVERAL DAYS",
                    value: 1,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("2");
                    });
                    },

                  ),
                  GFRadioListTile(titleText: "MORE THAN HALF THE DAYS",
                    value: 2,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("3");
                    });
                    },

                  ), 
                  GFRadioListTile(titleText: "ALMOST EVERYDAY",
                    value: 3,
                    groupValue: value,
                    onChanged:(val){setState(() {
                      value = val;
                      selectedOption =  <String>[];
                      selectedOption.add("4");
                    });
                    },

                  ),



            ],
          ),
      );

  }
question28(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: () async =>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "28":value,
                    "next":30,
                    "Q28":value == 0?false:true,
                  }),
                  selectedOption = <String>[],
                  value == 0?pageController.animateToPage(35, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut):
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                  value = null,
                   doc = await usersRef.doc(currentUser.id).get(),
                  currentUser = Users.fromDocument(doc),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("If you have experienced any horrible, frightening or traumatic kind of event, kindly select 'YES'. If not, select No.?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),
            GFRadioListTile(titleText: "YES",
              value: 1,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("1");
              });
              },

            ),  
            GFRadioListTile(titleText: "NO",
              value: 0,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("2");
              });
              },

            ),




            ],
          ),
      );

  }
question29(){

    return
      Scaffold(
        backgroundColor: Colors.blue,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.blue, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "29":value,
                    "next":31,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("IN THE PAST MONTH HAVE YOU,\nHad nightmares about the event(s) or thought about the event(s) when you did not want to?",
                    style:TextStyle(fontSize: MediaQuery.of(context).size.width/14,color: Colors.white)),
              ),
SizedBox(height:8),

   GFRadioListTile(titleText: "YES",
                color: Colors.white,
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },

              ),
              GFRadioListTile(titleText: "NO",
                color: Colors.white,

                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),

            ],
          ),
      );

  }
question30(){

    return
      Scaffold(
        backgroundColor: Colors.blue,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.blue, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "30":value,
                    "next":32,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Tried hard not to think about the event(s) or went out of your way to avoid situations that reminded you of the event(s)?"
                    ,style:TextStyle(fontSize: MediaQuery.of(context).size.width/14,color:Colors.white)),
              ),
SizedBox(height:8),

   GFRadioListTile(titleText: "YES",
     color:Colors.white,
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },

              ),
              GFRadioListTile(titleText: "NO",
                color:Colors.white,
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),

            ],
          ),
      );

  }
question31(){

    return
      Scaffold(
        backgroundColor: Colors.blue,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.blue, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "31":value,
                    "next":33,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Been constantly on guard, watchful, or easily startled?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14,color:Colors.white)),
              ),
SizedBox(height:8),

   GFRadioListTile(titleText: "YES",
     color:Colors.white,
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },

              ),
              GFRadioListTile(titleText: "NO",
                color:Colors.white,
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),

            ],
          ),
      );

  }
question32(){

    return
      Scaffold(
        backgroundColor: Colors.blue,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.blue, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "32":value,
                    "next":34,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Felt numb or detached from people, activities, or your surroundings?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14,color:Colors.white)),
              ),
SizedBox(height:8),

   GFRadioListTile(titleText: "YES",
     color:Colors.white,
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },

              ),
              GFRadioListTile(titleText: "NO",
                color:Colors.white,
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),

            ],
          ),
      );

  }
question33(){

    return
      Scaffold(
        backgroundColor: Colors.blue,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.blue,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.blue, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "33":value,
                    "next":35,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Felt guilty or unable to stop blaming yourself or others for the event(s) or any problems the event(s) may have caused?"
                    ,style:TextStyle(fontSize: MediaQuery.of(context).size.width/14,color:Colors.white)),
              ),
SizedBox(height:8),

   GFRadioListTile(titleText: "YES",
     color:Colors.white,
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },

              ),
              GFRadioListTile(titleText: "NO",
                value: 0,
                color:Colors.white,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),

            ],
          ),
      );

  }
  midPage_Page35(){
    return
      Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){
              print("<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>${currentUser.Ques28}");

              currentUser.Ques28?
              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut):
             pageController.animateToPage(29, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
              print(">>????????????${currentUser.Ques28}");

            },),

            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                  primary:Colors.green.shade700), child:Text("Next"),onPressed: () async {
                usersRef.doc(currentUser.id).update({
                  "next":36,
                });
                selectedOption = <String>[];
                pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
                  doc = await usersRef.doc(currentUser.id).get();
                currentUser = Users.fromDocument(doc);
              },),
            ]),
        body: Container(
          color: Colors.white,

          child: ListView(

            children: <Widget>[
              SizedBox(height:MediaQuery.of(context).size.height/4),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("YOU ARE ALMOST THERE PLEASE CONTINUE ANSWERING A FEW MORE QUESTIONS",style:TextStyle(fontSize: MediaQuery.of(context).size.height/16)),
              ),
              SizedBox(height:MediaQuery.of(context).size.height/2),

            ],
          ),
        ),
      );

  }

  question34(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "34":value,
                    "next":37,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Are you unsure where to go to seek professional care?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

            GFRadioListTile(titleText: "NOT AT ALL",
              value: 0,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("1");
              });
              },
            ),
            GFRadioListTile(titleText: "A LITTLE",
              value: 1,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("2");
              });
              },

            ),
            GFRadioListTile(titleText: "QUIET A LOT",
              value: 2,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("3");
              });
              },

            ),
            GFRadioListTile(titleText: "A LOT",
              value: 3,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("4");
              });
              },

            ),



            ],
          ),
      );

  }
question35(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "35":value,
                    "next":38,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Do you want to solve the problem on your own?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),
              GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "A LITTLE",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "QUIET A LOT",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "A LOT",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),





            ],
          ),
      );

  }
question36(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "36":value,
                    "next":39,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Do you feel that you will get better by yourself without doing anything?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

              GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "A LITTLE",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "QUIET A LOT",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "A LOT",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),



            ],
          ),
      );

  }
question37(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "37":value,
                    "next":40,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Are you concerned that you might be seen as weak for having a mental issue?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

              GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "A LITTLE",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "QUIET A LOT",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "A LOT",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),



            ],
          ),
        );

  }
question38(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "38":value,
                    "next":41,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Are you concerned that your issue might harm your chances of getting a job?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

              GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "A LITTLE",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "QUIET A LOT",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "A LOT",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),



            ],
          ),
      );

  }
question39(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "39":value,
                    "next":42,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Are you concerned what your family might think, say or feel?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

              GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "A LITTLE",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "QUIET A LOT",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "A LOT",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),



            ],
          ),
      );

  }
question40(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "40":value,
                    "next":43,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Are you afraid you will not be able to afford the financial costs?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

              GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "A LITTLE",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "QUIET A LOT",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "A LOT",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),



            ],
          ),
      );

  }
question41(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "41":value,
                    "next":44,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Are you afraid you will be seen as crazy for seeking medical attention?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

              GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "A LITTLE",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "QUIET A LOT",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "A LOT",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),



            ],
          ),
      );

  }
question42(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "42":value,
                    "next":45,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Do you dislike talking about your feelings, emotions or thoughts?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

              GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "A LITTLE",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "QUIET A LOT",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "A LOT",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),



            ],
          ),
      );

  }
question43(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{
                  usersRef.doc(currentUser.id).update({
                    "43":value,
                    "next":46,
                  }),
                  selectedOption = <String>[],
                  value = null,
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),
                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Are you concerned people might not take you seriously if they found out you are seeking professional help?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

              GFRadioListTile(titleText: "NOT AT ALL",
                value: 0,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("1");
                });
                },
              ),
              GFRadioListTile(titleText: "A LITTLE",
                value: 1,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("2");
                });
                },

              ),
              GFRadioListTile(titleText: "QUIET A LOT",
                value: 2,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("3");
                });
                },

              ),
              GFRadioListTile(titleText: "A LOT",
                value: 3,
                groupValue: value,
                onChanged:(val){setState(() {
                  value = val;
                  selectedOption =  <String>[];
                  selectedOption.add("4");
                });
                },

              ),



            ],
          ),
      );

  }
question44(){

    return
      Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading:   IconButton(icon:Icon(Icons.arrow_back_ios,color: Colors.black,),onPressed: (){

              pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);

            },),
            actions:[
              ElevatedButton(style:ElevatedButton.styleFrom(
                primary:Colors.green.shade700, // b
              ),
                child:Text("Next"),onPressed: ()async=>
                selectedOption.isEmpty?     Fluttertoast.showToast(
                    msg: "Please select an option", timeInSecForIos: 4,gravity: ToastGravity.TOP):{

                  selectedOption = <String>[],
                  value = null,
                  q28Score =
                     currentUser.Q28+currentUser.Q29+currentUser.Q30+
                      currentUser.Q31+currentUser.Q32+currentUser.Q33,
                  assessment = currentUser.Q2+currentUser.Q3+currentUser.Q4+currentUser.Q5+currentUser.Q6+currentUser.Q7+currentUser.Q8+
                      currentUser.Q9+currentUser.Q10+currentUser.Q11+currentUser.Q12+currentUser.Q13+currentUser.Q14+currentUser.Q15+
                      currentUser.Q16+currentUser.Q17+currentUser.Q18+currentUser.Q19+currentUser.Q20+currentUser.Q21+currentUser.Q22+
                      currentUser.Q23+currentUser.Q24+currentUser.Q25+currentUser.Q26+currentUser.Q27+
                      currentUser.Q34+currentUser.Q35+currentUser.Q36+currentUser.Q37+currentUser.Q38+
                      currentUser.Q39+currentUser.Q40+currentUser.Q41+currentUser.Q42+currentUser.Q43+currentUser.Q44,
                  usersRef.doc(currentUser.id).update({
                    "44":value,
                    "answered":true,
                    "next":47,
                   "totalPoints": assessment,
                    "Ques28Points":q28Score,
                  }),
                 doc = await usersRef.doc(currentUser.id).get(),
                 currentUser = Users.fromDocument(doc),
                  pageController.animateToPage(++pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut),

                },),
            ]),
        body: ListView(
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height/12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Do you feel that mental health problems are all just a modern day made up issue?",style:TextStyle(fontSize: MediaQuery.of(context).size.width/14)),
              ),
SizedBox(height:8),

            GFRadioListTile(titleText: "NOT AT ALL",
              value: 0,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("1");
              });
              },
            ),
            GFRadioListTile(titleText: "A LITTLE",
              value: 1,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("2");
              });
              },

            ),
            GFRadioListTile(titleText: "QUIET A LOT",
              value: 2,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("3");
              });
              },

            ),
            GFRadioListTile(titleText: "A LOT",
              value: 3,
              groupValue: value,
              onChanged:(val){setState(() {
                value = val;
                selectedOption =  <String>[];
                selectedOption.add("4");
              });
              },

            ),




            ],
          ),
      );

  }

  @override
  Widget build(BuildContext context) {
    return    Container(
      height:MediaQuery.of(context).size.height,
      width:MediaQuery.of(context).size.width,
      child: PageView(
        physics:new NeverScrollableScrollPhysics(),
        pageSnapping: true,
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            pageChanged = index;
          });
          print(pageChanged);
        },
        children: [
          Container(
            child: intro(),
          ),
         Container(
            child: question1(),
          ),
         Container(
            child: question2(),
          ),
         Container(
            child: question3(),
          ),
         Container(
            child: question4(),
          ),
         Container(
            child: question5(),
          ),
         Container(
            child: question6(),
          ),
         Container(
            child: question7(),
          ),
         Container(
            child: question8(),
          ),
         Container(
            child: question9(),
          ),
         Container(
            child: question10(),
          ),
         Container(
            child: question11(),
          ),
         Container(
            child: question12(),
          ),
         Container(
            child: question13(),
          ),
          Container(
            child: midPage_Page14(),
          ),

         Container(
            child: question14(),
          ),
         Container(
            child: question15(),
          ),
         Container(
            child: question16(),
          ),
         Container(
            child: question17(),
          ),
         Container(
            child: question18(),
          ),
         Container(
            child: question19(),
          ),
         Container(
            child: question20(),
          ),
         Container(
            child: question21(),
          ),
         Container(
            child: question22(),
          ),
         Container(
            child: question23(),
          ),
         Container(
            child: question24(),
          ),
         Container(
            child: question25(),
          ),
         Container(
            child: question26(),
          ),
         Container(
            child: question27(),
          ),
         Container(
            child: question28(),
          ),
         Container(
            child: question29(),
          ),
         Container(
            child: question30(),
          ),
         Container(
            child: question31(),
          ),
         Container(
            child: question32(),
          ),
         Container(
            child: question33(),
          ),
          Container(
            child: midPage_Page35(),
          ),

          Container(
            child: question34(),
          ),
         Container(
            child: question35(),
          ),
         Container(
            child: question36(),
          ),
         Container(
            child: question37(),
          ),
         Container(
            child: question38(),
          ),
         Container(
            child: question38(),
          ),
         Container(
            child: question39(),
          ),
         Container(
            child: question40(),
          ),
         Container(
            child: question41(),
          ),
         Container(
            child: question42(),
          ),
         Container(
            child: question43(),
          ),
         Container(
            child: question44(),
          ),
 Container(
            child: AssessmentScore(),
          ),



        ],
      ),
    );
  }
}
