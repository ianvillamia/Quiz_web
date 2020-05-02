import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
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

  Future<void> deleteQuestion(
      {@required String collectionID, @required String documentID}) {
    return db.collection(collectionID).document(documentID).delete();
  }

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

  Future updateQuizSubjects(
      {@required String documentID,
      @required List subjects,
      @required String curentQuiz}) async {
    try {
      //get document id first

      await db
          .collection('quizToSubjects')
          .document(documentID)
          .updateData({'subjects': subjects});
      // document id meaning
      
      // for every subject update thing
      // currentID quiz aka title to be added subjectList

      // i can access title ofquiz and subjects

      // updatesubjectList
      // get current quiz from thing but i need provider

    } catch (e) {
      print('error' + e.toString());
    }
  }

  //updating quizID for subjectList
  Future updateQuizzesForSubjectList({@required String title})async{
    db
        .collection('subjectList')
        .where('title', isEqualTo:title)
        .limit(1)
        .snapshots()
        .listen((data) async {
      data.documents.forEach((data) async {
        print(data.documentID);
        //await db.collection('quizList').document(data.documentID).delete();
      });
                //pop quiz from title here
                //step1 get array quizzesID from subjectList
                //step2 remove this.title from array just list.remove()
           });   //step3 commit array to this.title aka subjects
  }
}
