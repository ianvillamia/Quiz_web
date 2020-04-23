import 'package:flutter/foundation.dart';

class QuizProvider with ChangeNotifier {
  bool isTimerVisible = false;
  String currentQuiz = '';
  int initCounter = 0;
  bool isInit = true;
  int scroreCounter = 0;
  int trueOrFalseAnswer;
  int multipleChoiceValue;
  List subjects = [];
  String subjectTitle;
   void countInit(){
    initCounter++;
  }
  void changeInit(bool val){
    isInit=val;
    //notifyListeners();
  }
  Future updateSubjects(List data) async{
    subjects = data;
    notifyListeners();
  }

  Future updateCurrentQuiz({@required String data}) async{
    currentQuiz = data;
  
    notifyListeners();
  }

  void onChangeMultipleChoice(
      {@required String correctAnswer, @required String userAnswer}) {
    answerChecker(userAnswer: userAnswer, correctAnswer: correctAnswer);
  }

  void onchangeTrueOrFalse(
      {@required int val, @required String correctAnswer}) {
    trueOrFalseAnswer = val;
    if (val == 1) {
      answerChecker(userAnswer: "True", correctAnswer: correctAnswer);
    } else {
      answerChecker(userAnswer: "False", correctAnswer: correctAnswer);
    }
  }

   changeTimer(bool val) {
    isTimerVisible = val;
    notifyListeners();
  }

  void answerChecker(
      {@required String userAnswer, @required String correctAnswer}) {
   
    var ans1 = userAnswer.toLowerCase();
  var ans2=correctAnswer.toLowerCase();

    if (ans1==ans2) {
      scroreCounter++;
      print('correct' + scroreCounter.toString());
    } else {
      if (scroreCounter > 0) {
        scroreCounter--;
      }
    }
  }
}
