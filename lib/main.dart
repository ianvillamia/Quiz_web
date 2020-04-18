import 'dart:async';

import 'package:Quiz_web/Services/Firebase/authenticationService.dart';
import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:Quiz_web/Services/Providers/reviewerProvider.dart';
import 'package:Quiz_web/Services/routing.dart';
import 'package:Quiz_web/wrapper.dart';
import 'Models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  FluroRouter.setupRouter();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    AuthenticationService auth = AuthenticationService();
  
    return MultiProvider(
      providers: [
        //add providers here
        StreamProvider<User>(
            create: (_) => auth.user 
           ),

        ListenableProvider<QuizProvider>(create: (_) => QuizProvider()),
        ListenableProvider<ReviewerProvider>(create: (_) => ReviewerProvider()),
        ChangeNotifierProvider<LoginListener>(
          create: (_) => LoginListener(),
        ),
       
      ],
      child: MaterialApp(
        title: "QuizApp",
        onGenerateRoute: FluroRouter.router.generator,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        home: Wrapper(),
      ),
    );
  }
}
