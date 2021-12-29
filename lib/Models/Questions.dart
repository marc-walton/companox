import 'package:companox/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class Questions extends StatefulWidget {

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  PageController pageController = PageController(initialPage: currentUser.next);
  int pageChanged  = 0;
  bool isUploading;
  question1(){
    return
      ModalProgressHUD(

        inAsyncCall: isUploading,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Row(
                children: [
                  InkWell(
                    onTap: (){
                      pageController.animateToPage(--pageChanged, duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
                    },
                    child: FittedBox(
                      fit:  BoxFit.fitHeight,
                      child: Container(
                        alignment:Alignment.center,
                        height:MediaQuery. of(context). size. height *0.06,

                        width:MediaQuery. of(context). size. width *0.5,

                        //icon: Icon(Icons.drag_handle),
                        child:Text("Previous",style:TextStyle(color: Colors.black)),

                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      isUploading ? null : null;
                    },
                    child: FittedBox(
                      fit:  BoxFit.fitHeight,
                      child: Container(
                        alignment:Alignment.center,
                        height:MediaQuery. of(context). size. height *0.06,

                        width:MediaQuery. of(context). size. width *0.5,

                        //icon: Icon(Icons.drag_handle),
                        child:Text("Next",style:TextStyle(color: Colors.black)),

                      ),
                    ),
                  ),


                ],
              ),




            ],
          ),
        ),
      );

  }
  @override
  Widget build(BuildContext context) {
    return                 PageView(
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
          child: question1(),
        ),


      ],
    );
  }
}
