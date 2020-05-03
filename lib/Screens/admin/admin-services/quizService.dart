import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class QuizService {

  final db = Firestore.instance;
/************************************Quiz-Modification**********************************************/

  Future createQuiz(
      {@required BuildContext context,
      @required String title,
      @required String instructions,
      @required int hour,
      @required int minute,
      @required String creator}) async {
    try {
      //first add the quiz to quizList
      await db.collection('quizList').add({'title': title, 'ID': title});

      //second create the header for quiz
      await db.collection(title).add({
        'creator': creator,
        'instructions': instructions,
        'order': '0',
        'hour': hour,
        'minute': minute,
        'title': title,
        'type': 'header',
      });
    } catch (e) {
      print('create fail' + e.toString());
      return e;
    }
  }

  Future deleteQuiz({@required String collectionID}) async {
    //delete quiz in QUizlist
    //firrst query id then delete
    db
        .collection('quizList')
        .where('title', isEqualTo: collectionID)
        .limit(1)
        .snapshots()
        .listen((data) async {
      data.documents.forEach((data) async {
        print(data.documentID);
        await db.collection('quizList').document(data.documentID).delete();
      });
    });

    //delete collection nagana na to lol
    await db.collection(collectionID).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }

/************************************Quiz-QUESTIONS**********************************************/
/************************************CREATE******************************************************/
  createQuizQuestion() {
    Future addMultipleQuestion(
        {@required String answer,
        @required String question,
        @required List choices,
        @required String collectionID}) async {
      try {
        QuerySnapshot _myDoc =
            await Firestore.instance.collection(collectionID).getDocuments();
        List<DocumentSnapshot> _myDocCount = _myDoc.documents;

        await db.collection(collectionID).add({
          'answer': answer.toLowerCase().trim(),
          'order': (_myDocCount.length).toString(),
          'question': question,
          'choices': choices,
          'questionType': 'multipleChoice'
        });
      } catch (e) {}
    }

    Future addIdentificationQuestion(
        {@required String answer,
        @required String question,
        @required String collectionID}) async {
      try {
        QuerySnapshot _myDoc =
            await Firestore.instance.collection(collectionID).getDocuments();
        List<DocumentSnapshot> _myDocCount = _myDoc.documents;

        await db.collection(collectionID).add({
          'answer': answer.toLowerCase().trim(),
          'order': (_myDocCount.length).toString(),
          'question': question,
          'questionType': 'identification'
        }).then((value) => print('success'));
      } catch (e) {
        print('error' + e.toString());
      }
    }

    Future addTrueOrFalseQuestion(
        {@required bool answer,
        @required String question,
        @required String collectionID}) async {
      try {
        QuerySnapshot _myDoc =
            await Firestore.instance.collection(collectionID).getDocuments();
        List<DocumentSnapshot> _myDocCount = _myDoc.documents;

        await db.collection(collectionID).add({
          'answer': answer,
          'order': (_myDocCount.length).toString(),
          'question': question,
          'questionType': 'trueOrFalse'
        });
      } catch (e) {}
    }
  }
/************************************Update******************************************************/

  updateQuiz() {
    Future updateMultipleChoiceQuestion(
        //for indentification and true or false
        {@required String question,
        @required String answer,
        @required List choices,
        @required DocumentSnapshot doc,
        @required BuildContext context}) async {
      print('object');
      //   String collectionID=doc.data['title'].toString();
      final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
      var collectionID = _adminProvider.currentQuiz;
      print(doc.documentID); //ok na collection na lang
      print(collectionID);
      try {
        await db.collection(collectionID).document(doc.documentID).updateData(
            {'question': question, 'answer': answer, 'choices': choices});
      } catch (e) {
        print('error' + e.toString());
      }
    }

    Future updateIdentificationQuestion(
        {@required String question,
        @required String answer,
        @required DocumentSnapshot doc,
        @required BuildContext context}) async {
      print('object');
      //   String collectionID=doc.data['title'].toString();
      final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
      var collectionID = _adminProvider.currentQuiz;
      print(doc.documentID); //ok na collection na lang
      print(collectionID);

      try {
        await db
            .collection(collectionID)
            .document(doc.documentID)
            .updateData({'question': question, 'answer': answer});
      } catch (e) {
        print('error' + e.toString());
      }
    }

    Future updateQuizHeader(
        {@required String creatorName,
        @required String instructions,
        @required String title,
        @required int hour,
        @required int minute,
        @required DocumentSnapshot doc,
        @required BuildContext context}) async {
      print('object');
      final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
      var collectionID = _adminProvider.currentQuiz;
      print(doc.documentID); //ok na collection na lang
      print(collectionID);

      try {
        await db.collection(collectionID).document(doc.documentID).updateData({
          'creator': creatorName,
          'instructions': instructions,
          'hour': hour,
          'minute': minute,
          'title': title
        });
      } catch (e) {
        print('error' + e.toString());
      }
    }

    Future updateTrueOrFalseQuestion(
        //for indentification and true or false
        {@required String question,
        @required bool answer,
        @required DocumentSnapshot doc,
        @required BuildContext context}) async {
      print('object');
      //   String collectionID=doc.data['title'].toString();
      final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
      var collectionID = _adminProvider.currentQuiz;
      print(doc.documentID); //ok na collection na lang
      print(collectionID);

      try {
        await db
            .collection(collectionID)
            .document(doc.documentID)
            .updateData({'question': question, 'answer': answer});
      } catch (e) {
        print('error' + e.toString());
      }
    }
  }

  Future<void> deleteQuestion(
      {@required String collectionID, @required String documentID}) {
    return db.collection(collectionID).document(documentID).delete();
  }

  //end of class
}
