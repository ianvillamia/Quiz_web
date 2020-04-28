import 'package:flutter/foundation.dart';

class AdminProvider with ChangeNotifier {
  bool isSubjectOk = false;
  String errorText;
  bool editable = true;
  String createQuizTitle;
  String currentQuiz;

  bool isRadioSelected=false;
  void toggleRadio({@required bool val}){
    isRadioSelected=val;
    notifyListeners();
  }

  void changeCurrentQuiz({@required String quiz}){
    currentQuiz=quiz;
    notifyListeners();
  }
  int selected;
  void changeSelection(int val) {
    selected = val;
    notifyListeners();
  }

  bool isDeleteButtonVisible = false;
  void toggleDeleteButton(bool val) {
    isDeleteButtonVisible = val;
    notifyListeners();
  }

  void setQuizTitle(String val) {
    createQuizTitle = val;
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
