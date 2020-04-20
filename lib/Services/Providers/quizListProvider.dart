import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class QuizListProvider with ChangeNotifier {
List subjects=[];
String subjectTitle;
  updateSubjects(List data){
    subjects = data;
    notifyListeners();
  }
}
