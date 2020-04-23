import 'package:Quiz_web/Screens/authScreens/loginScreen.dart';
import 'package:Quiz_web/Screens/authScreens/signupScreen.dart';
import 'package:Quiz_web/Screens/authenticatedHome.dart';
import 'package:Quiz_web/Screens/home.dart';
import 'package:Quiz_web/Screens/quizScreens/quizListBuilder.dart';
import 'package:Quiz_web/Screens/quizScore.dart';
import 'package:Quiz_web/Screens/flipCards.dart';
import 'package:Quiz_web/Screens/quizScreens/quizBuilder.dart';
import 'package:Quiz_web/wrapper.dart';
import 'package:flip_card/flip_card.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _homehandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Home());

  static Handler _loginHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginScreen());

  static Handler _quizhandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          QuizBuilder());

  static Handler _reviewerHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          FlipCards());

  static Handler _quizScoreHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          QuizScore());

  static Handler _wrapperHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Wrapper());

  static Handler _signupHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SignUp());

  static Handler _authenticatedHomeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          AuthenticatedHome());
           static Handler _quizListBuilder = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          QuizListBuilder());

          
//-----------------------Routenames----------------------------------------//
  static void setupRouter() {
    router.define('/',
        handler: _wrapperHandler, transitionType: TransitionType.fadeIn);
router.define('/quizList',
        handler: _quizListBuilder, transitionType: TransitionType.fadeIn);
    router.define('/login',
        handler: _loginHandler, transitionType: TransitionType.cupertino);

    router.define('/authenticatedHome',
        handler: _authenticatedHomeHandler,
        transitionType: TransitionType.fadeIn);

    router.define('/signup',
        handler: _signupHandler, transitionType: TransitionType.cupertino);

    router.define('/home',
        handler: _homehandler, transitionType: TransitionType.fadeIn);

    router.define('/quiz',
        handler: _quizhandler, transitionType: TransitionType.fadeIn);

    router.define('/flipCards',
        handler: _reviewerHandler, transitionType: TransitionType.fadeIn);

    router.define('/quizScore',
        handler: _quizScoreHandler, transitionType: TransitionType.fadeIn);
  }
}
