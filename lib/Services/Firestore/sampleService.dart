import 'package:cloud_firestore/cloud_firestore.dart';

class SampleService {
  final db = Firestore.instance;

  Future createCollection() {
    db.collection('SomeCollection').document('documentName').setData({
      "Flutter":"awesome"
    });
  }
}
