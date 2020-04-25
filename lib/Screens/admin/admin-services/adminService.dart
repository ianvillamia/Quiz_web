import 'package:Quiz_web/Screens/admin/admin-providers/adminSubjectProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminService {
  final db = Firestore.instance;

  Future addSubject(
      {@required String subject, @required String details}) async {
    try {
      QuerySnapshot _myDoc =
          await Firestore.instance.collection('subjectList').getDocuments();
      List<DocumentSnapshot> _myDocCount = _myDoc.documents;

      await db.collection('subjectList').add({
        'title': subject,
        'order': (_myDocCount.length + 1).toString(),
        'details': details,
        'quizzesID': []
      });
    } catch (e) {
      print('error' + e.toString());
    }
  }

  ///
  Future updateSubject(
      {@required String subject,
      @required String details,
      String docID}) async {
    try {
      await db
          .collection('subjectList')
          .document(docID)
          .updateData({'title': subject, 'details': details});
    } catch (e) {
      print('error' + e.toString());
    }
  }

  //
  Future deleteSubject({@required String docID}) async {
    try {
      await db.collection('subjectList').document(docID).delete();
    } catch (e) {}
  }

  Future createQuiz(
      {@required BuildContext context,
      @required String title,
      @required String instructions,
      @required String time,
      @required String creator}) async {
    try {
      //first add the quiz to quizList
      await db.collection('quizList').add({'title': title, 'ID': title});

      //second create the header for quiz
      await db.collection(title).add({
        'creator': creator,
        'instructions': instructions,
        'order': '0',
        'time': time,
        'type': 'header',
        'title':title
      });
    } catch (e) {
      print('create fail' + e.toString());
      return e;
    }
  }
}
