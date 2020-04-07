import 'package:flutter/foundation.dart';

class QuizProvider with ChangeNotifier {
  bool isTimerVisible = false;
  int initCounter = 1;
  bool isInit = true;
  int scroreCounter=0;
  void changeTimer(bool val) {
    isTimerVisible = val;
    notifyListeners();
  }

  void answerChecker({@required String userAnswer, @required String correctAnswer}) {
   print(userAnswer);
   print(correctAnswer);
    if(userAnswer==correctAnswer){
      scroreCounter++;
      print('correct'+scroreCounter.toString());
    }
  }
}
