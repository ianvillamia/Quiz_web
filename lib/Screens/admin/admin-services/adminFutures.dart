import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class AdminFutures{
  
 static Future<bool> checkDuplicates(
      {@required String question, @required String collection}) async {
    try {
      final QuerySnapshot result = await Firestore.instance
          .collection(collection)
          .where('question', isEqualTo: question)
          .limit(1)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      return documents.length == 1;
    } catch (err) {}
  }
}