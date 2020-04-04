
import 'package:Quiz_web/Services/routing.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter/material.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QuizApp",
      initialRoute: '/',
      onGenerateRoute: FluroRouter.router.generator,
      debugShowCheckedModeBanner: false,
    
    );
  }
}
