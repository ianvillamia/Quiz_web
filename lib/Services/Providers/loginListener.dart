import 'package:Quiz_web/Services/SharedPreferences/sharedPrefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Quiz_web/Models/userState.dart';
import 'package:Quiz_web/Services/SharedPreferences/sharedPrefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginListener with ChangeNotifier {
  FirebaseAuth auth;
  FirebaseUser user;
  SharedData sharedData = SharedData();

  bool isLoggedIn;
  UserState status;
  LoginListener() {
    //constructor
    print('object');
    setupValues();
  }

  void updateStatus({UserState state}) async {
    status = state;
    print(status);
    //every update set 
    final pref = await SharedPreferences.getInstance();
    if(state!=UserState.Authenticated){
   pref.setBool('isLoggedIn', false);
    }
    else{
      pref.setBool('isLoggedIn', true);
    }
 
    notifyListeners();
  }

  void setupValues() async {
    bool isLoggedIn = await sharedData.getSharedPrefData(key: 'isLoggedIn');
    int initCounter = await sharedData.getSharedPrefData(key: 'startupNumber');
  
    if (initCounter == 1) {
      if (isLoggedIn) {
        updateStatus(state: UserState.Authenticated);
      } else {
        updateStatus(state: UserState.Unauthenticated);
      }
      updateStatus(state: UserState.Unauthenticated);
    }
  }
}
