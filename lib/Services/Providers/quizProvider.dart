import 'package:flutter/foundation.dart';

class QuizProvider with ChangeNotifier {
  bool isTimerVisible = false;
  int initCounter = 1;
  bool isInit = true;
  int scroreCounter = 0;
  int trueOrFalseAnswer;
  int multipleChoiceValue;
  QuizProvider();

  void changeTrueOrFalse({@required int val, @required String correctAnswer}) {
    trueOrFalseAnswer = val;
    if (val == 1) {
      answerChecker(userAnswer: "True", correctAnswer: correctAnswer);
    } else {
      answerChecker(userAnswer: "False", correctAnswer: correctAnswer);
    }
    notifyListeners();
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
