import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Quiz_web/Models/userState.dart';

class LoginListener with ChangeNotifier {
  FirebaseAuth auth;
  FirebaseUser user;
  UserState status = UserState.Unauthenticated;
var counter=0;
  void updateStatus({UserState state}){
 
    status=state;
       print(status);
    notifyListeners();

  }
  


}
