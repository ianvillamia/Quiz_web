import 'package:Quiz_web/Models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }
//auth change user Stream
// Stream<FirebaseUser> get user{
//   return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
// }

  Future registerWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return Future.error({e});
    }
  }

  Future signInWithEmailAndPassword(
      {@required email, @required String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return Future.error({e});
    }
  }
}
