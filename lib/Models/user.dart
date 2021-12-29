import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String id;
  String email;
  String photoUrl;
  String displayName;
bool Ques28;
  bool answered;
  int next;
  int  Q1;
   int  Q2;
   int  Q3;
   int  Q4;
   int  Q5;
   int  Q6;
   int  Q7;
   int  Q8;
   int  Q9;
   int  Q10;
   int  Q11;
   int  Q12;
   int  Q13;
   int  Q14;
   int  Q15;
   int  Q16;
   int  Q17;
   int  Q18;
   int  Q19;
   int  Q20;
   int  Q21;
   int  Q22;
   int  Q23;
   int  Q24;
   int  Q25;
   int  Q26;
   int  Q27;
   int  Q28;
   int  Q29;
   int  Q30;
   int  Q31;
    int  Q32;
    int  Q33;
    int  Q34;
    int  Q35;
    int  Q36;
    int  Q37;
    int  Q38;
    int  Q39;
    int  Q40;
    int  Q41;
    int  Q42;
    int  Q43;
    int  Q44;

  Users({
    this.id,
    this.email,
    this.photoUrl,
    this.displayName,
       this.answered,
  this.next,
    this.Ques28,

 this.Q1,
 this.Q2,
 this.Q3,
 this.Q4,
 this.Q5,
 this.Q6,
 this.Q7,
 this.Q8,
 this.Q9,
 this.Q10,
 this.Q11,
 this.Q12,
 this.Q13,
 this.Q14,
 this.Q15,
 this.Q16,
 this.Q17,
 this.Q18,
 this.Q19,
 this.Q20,
 this.Q21,
 this.Q22,
 this.Q23,
 this.Q24,
 this.Q25,
 this.Q26,
 this.Q27,
 this.Q28,
 this.Q29,
 this.Q30,
 this.Q31,
 this.Q32,
 this.Q33,
this.Q34,
this.Q35,
this.Q36,
this.Q37,
this.Q38,
this.Q39,
this.Q40,
this.Q41,
this.Q42,
this.Q43,
this.Q44,


  });
  factory Users.fromDocument(DocumentSnapshot doc){
    return Users(
      id: doc.data()['id'],
      email :doc.data()['email'],
      photoUrl: doc.data()['photoUrl'],
      displayName :doc.data()['displayName'],

      answered: doc.data()['answered'],
 next: doc.data()['next'],
      Ques28: doc.data()['Q28'],

   Q1: doc.data()['1'],
Q2: doc.data()['2'],
Q3: doc.data()['3'],
Q4: doc.data()['4'],
Q5: doc.data()['5'],
Q6: doc.data()['6'],
Q7: doc.data()['7'],
Q8: doc.data()['8'],
Q9: doc.data()['9'],
Q10: doc.data()['10'],
Q11: doc.data()['11'],
Q12: doc.data()['12'],
Q13: doc.data()['13'],
Q14: doc.data()['14'],
Q15: doc.data()['15'],
Q16: doc.data()['16'],
Q17: doc.data()['17'],
Q18: doc.data()['18'],
Q19: doc.data()['19'],
Q20: doc.data()['20'],
Q21: doc.data()['21'],
Q22: doc.data()['22'],
Q23: doc.data()['23'],
Q24: doc.data()['24'],
Q25: doc.data()['25'],
Q26: doc.data()['26'],
Q27: doc.data()['27'],
Q28: doc.data()['28'],
Q29: doc.data()['29'],
Q30: doc.data()['30'],
Q31: doc.data()['31'],
Q32: doc.data()['32'],
Q33: doc.data()['33'],
Q34: doc.data()['34'],
Q35: doc.data()['35'],
Q36: doc.data()['36'],
Q37: doc.data()['37'],
Q38: doc.data()['38'],
Q39: doc.data()['39'],
Q40: doc.data()['40'],
Q41: doc.data()['41'],
Q42: doc.data()['42'],
Q43: doc.data()['43'],
Q44: doc.data()['44'],

    );
  }
}
