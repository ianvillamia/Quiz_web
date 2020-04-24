import 'package:flutter/foundation.dart';
class AdminSubjectProvider with ChangeNotifier{
  bool isSubjectOk=false;
  String errorText;
  void checkSubject(bool val){
    isSubjectOk=val;
    notifyListeners();
  }
  void changeErrorString(String val){
    errorText=val;
    notifyListeners();
  }
}