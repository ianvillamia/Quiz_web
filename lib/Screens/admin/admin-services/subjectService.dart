import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SujectService {
  /* This is for the Crud for Subjects*/
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

  
  Future deleteSubject({@required String docID}) async {
    try {
      await db.collection('subjectList').document(docID).delete();
    } catch (e) {}
  }
}
