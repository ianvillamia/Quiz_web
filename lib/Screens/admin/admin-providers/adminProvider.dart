import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AdminProvider with ChangeNotifier {
  bool isSubjectOk = false;
  String errorText;
  bool editable = true;
  String createQuizTitle;
  String currentQuiz;
  List quizToSubjects;
  String quizToSubjectID;
 
  void quizSubjectPop({@required String val}) async{
    print(quizToSubjects);
    quizToSubjects.remove(val);
    print('croo');
    print(quizToSubjects);
    //do firebase update here
    await AdminService().updateQuizSubjects(documentID: quizToSubjectID.toString(), subjects: quizToSubjects);
    notifyListeners();
  }

  void quizSubjectPush({@required String val}) async{
    print(val);
   print(quizToSubjects);
    quizToSubjects.add(val);
    print('croo');
    print(quizToSubjects);
      //do firebase update here
   await AdminService().updateQuizSubjects(documentID: quizToSubjectID.toString(), subjects: quizToSubjects);
    notifyListeners();
  }

  bool isRadioSelected = false;
  void toggleRadio({@required bool val}) {
    isRadioSelected = val;
    notifyListeners();
  }

  void changeCurrentQuiz({@required String quiz}) {
    currentQuiz = quiz;
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
