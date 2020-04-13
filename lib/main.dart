import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:Quiz_web/Services/Providers/reviewerProvider.dart';
import 'package:Quiz_web/Services/routing.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  FluroRouter.setupRouter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //add providers here
        ListenableProvider<QuizProvider>(create: (_) => QuizProvider()),
        ListenableProvider<ReviewerProvider>(create: (_) => ReviewerProvider()),
        ChangeNotifierProvider<LoginListener>(
          create: (_) => LoginListener(),
        ),
      ],
      child: MaterialApp(
        title: "QuizApp",
        initialRoute: '/',
        onGenerateRoute: FluroRouter.router.generator,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
