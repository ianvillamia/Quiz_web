import 'package:flutter/foundation.dart';

class AdminProvider with ChangeNotifier {
  bool isSubjectOk = false;
  String errorText;
  bool editable = true;
  String createQuizTitle;

 
  void setQuizTitle(String val){
    createQuizTitle=val;
    notifyListeners();
  }
 

  void checkSubject(bool val) {
    isSubjectOk = val;
    notifyListeners();
  }

  void changeErrorString(String val) {
    errorText = val;
    notifyListeners();
  }

  void toggleSubjectUpdate(bool val) {
    editable = val;
    notifyListeners();
  }
}
