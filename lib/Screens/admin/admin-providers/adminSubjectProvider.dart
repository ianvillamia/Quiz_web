import 'package:flutter/foundation.dart';
class AdminSubjectProvider with ChangeNotifier{
  bool isSubjectOk=false;
  String errorText;
  bool editable=true;
  void checkSubject(bool val){
    isSubjectOk=val;
    notifyListeners();
  }
  void changeErrorString(String val){
    errorText=val;
    notifyListeners();
  }
  void toggleSubjectUpdate(bool val){
    editable=val;
    notifyListeners();
  }
}