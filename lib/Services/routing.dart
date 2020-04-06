import 'package:Quiz_web/Screens/home.dart';
import 'package:Quiz_web/Screens/quiz.dart';
import 'package:Quiz_web/Screens/review.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _homehandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Home());
  static Handler _quizhandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Quiz());
            static Handler _reviewerHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Reviewer());
  static void setupRouter() {
    router.define(
      '/',
      handler: _homehandler,
            transitionType: TransitionType.fadeIn
    );
       router.define(
      '/quiz',
      handler: _quizhandler,
      transitionType: TransitionType.fadeIn
    );
        router.define(
      '/reviewer',
      handler: _reviewerHandler,
      transitionType: TransitionType.fadeIn
    );
  
  }
}
