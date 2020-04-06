import 'package:cloud_firestore/cloud_firestore.dart';

class QuizService {
  final db = Firestore.instance;
  
  getQuiz<Stream>({String quiz}) {
    return db.collection(quiz).snapshots();
  }
}
