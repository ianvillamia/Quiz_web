import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
class QuizSubjectTileService{
getQuizTile(docID) async{


    Firestore.instance
        .collection(docID)
        .where("type", isEqualTo: "header").getDocuments();      
  }
}