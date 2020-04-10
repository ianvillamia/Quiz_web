import 'dart:html';

import 'package:firebase_web/firebase.dart' as fb;
import 'package:firebase_web/src/assets/assets.dart';

config() {
  try {
    fb.initializeApp(
        apiKey: "AIzaSyDldtDeXofJ3mB_DULxzZSXkbw32m_6GXg",
        authDomain: "quiz-app-38669.firebaseapp.com",
        databaseURL: "https://quiz-app-38669.firebaseio.com",
        storageBucket: "quiz-app-38669.appspot.com",
        projectId: "quiz-app-38669");

    //Your app here
  } on fb.FirebaseJsNotLoadedException catch (e) {
    print('error'+e.toString());
  }
}
