import 'package:flutter/foundation.dart';

class QuizProvider with ChangeNotifier {
  bool isTimerVisible = false;
  String currentQuiz = '';
  int initCounter = 1;
  bool isInit = true;
  int scroreCounter = 0;
  int trueOrFalseAnswer;
  int multipleChoiceValue;
  List subjects = [];
  String subjectTitle;
  updateSubjects(List data) {
    subjects = data;
    notifyListeners();
  }

  void updateCurrentQuiz({@required String data}) {
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

  void changeTimer(bool val) {
    isTimerVisible = val;
    notifyListeners();
  }

  void answerChecker(
      {@required String userAnswer, @required String correctAnswer}) {
    print(userAnswer);
    print(correctAnswer);
    if (userAnswer.toLowerCase() == correctAnswer.toLowerCase()) {
      scroreCounter++;
      print('correct' + scroreCounter.toString());
    } else {
      if (scroreCounter > 0) {
        scroreCounter--;
      }
    }
  }
}
