
import 'package:flutter/foundation.dart';

class QuizProvider with ChangeNotifier{
  bool isTimerVisible=false;

  void changeTimer(bool val){
    isTimerVisible=val;
    notifyListeners();
  }

}