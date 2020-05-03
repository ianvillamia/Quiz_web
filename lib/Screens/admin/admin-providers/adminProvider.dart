import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:flutter/foundation.dart';

class AdminProvider with ChangeNotifier {
  bool isSubjectOk = false;
  String errorText;
  bool editable = true;
  String createQuizTitle;
  String currentQuiz;
  List quizSubjects;
  String subjectListID;
  int createQuizStep=1;
  void updateQuizSubjects({@required List subjects, @required String id}){
    quizSubjects=subjects;
    subjectListID=id;
    notifyListeners();
  }
  void updateCreateQuizStep({@required val}){ 
    
    createQuizStep=val;
    notifyListeners();
  }

  void quizSubjectPop({@required String val}) async{
    print(quizSubjects);
    quizSubjects.remove(val);
    // print('croo');
    // print(quizToSubjects);
    //do firebase update here
    //i have current quiz here
    await AdminService().updateQuizSubjects(currentQuiz: currentQuiz,documentID: subjectListID.toString(), subjects: quizSubjects);
    
    notifyListeners();
  }

  void quizSubjectPush({@required String val}) async{
    print(val);
   print(quizSubjects);
    quizSubjects.add(val);
    // print('croo');
    // print(quizToSubjects);
    //   //do firebase update here
   await AdminService().updateQuizSubjects(currentQuiz: currentQuiz,documentID: subjectListID.toString(), subjects: quizSubjects);
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
