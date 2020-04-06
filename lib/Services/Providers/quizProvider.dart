
import 'package:flutter/foundation.dart';

class QuizProvider with ChangeNotifier{
  bool isTimerVisible=false;
  int initCounter=1;

  void changeTimer(bool val){
    isTimerVisible=val;
    notifyListeners();
  }

}