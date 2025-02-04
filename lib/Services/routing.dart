import 'package:Quiz_web/Screens/admin/adminScreens/adminCreateQuiz.dart';
import 'package:Quiz_web/Screens/admin/adminScreens/adminDash.dart';
import 'package:Quiz_web/Screens/admin/adminScreens/adminQuizzes.dart';
import 'package:Quiz_web/Screens/admin/adminScreens/adminSubjects.dart';
import 'package:Quiz_web/Screens/authScreens/loginScreen.dart';
import 'package:Quiz_web/Screens/authScreens/signupScreen.dart';
import 'package:Quiz_web/Screens/authenticatedHome.dart';
import 'package:Quiz_web/Screens/home.dart';
import 'package:Quiz_web/Screens/quizScreens/quizListBuilder.dart';
import 'package:Quiz_web/Screens/quizScore.dart';
import 'package:Quiz_web/Screens/flipCards.dart';
import 'package:Quiz_web/Screens/quizScreens/quizBuilder.dart';
import 'package:Quiz_web/Screens/reviewer.dart';
import 'package:Quiz_web/wrapper.dart';
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

  static Handler _flipCardsHandler = Handler(
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

  static Handler _quizListHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          QuizListBuilder());
  static Handler _reviewerHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param) =>
          Reviewer());
  static Handler _quizScoreHanlder = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param) =>
          QuizScore());
  static Handler _subjectsHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param) =>
          AdminSubjects());
  static Handler _quizzesHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param) =>
          AdminQuizzes());
            static Handler _createQuizHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param) =>
          AdminCreateQuiz());
              static Handler _adminHomeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> param) =>
          AdminHomeScreen());
//-----------------------Routenames----------------------------------------//
  static void setupRouter() {
    router.define('/',
        handler: _wrapperHandler, transitionType: TransitionType.fadeIn);
    router.define('/adminSubjects',
        handler: _subjectsHandler, transitionType: TransitionType.fadeIn);
         router.define('/adminCreateQuiz',
        handler: _createQuizHandler, transitionType: TransitionType.fadeIn);
            router.define('/adminHome',
        handler: _adminHomeHandler, transitionType: TransitionType.fadeIn);
    router.define('/adminQuizzes',
        handler: _quizzesHandler, transitionType: TransitionType.fadeIn);
    router.define('/quizScore',
        handler: _quizScoreHanlder, transitionType: TransitionType.fadeIn);
    router.define('/quizList',
        handler: _quizListHandler, transitionType: TransitionType.fadeIn);
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
        handler: _flipCardsHandler, transitionType: TransitionType.fadeIn);

    router.define('/quizScore',
        handler: _quizScoreHandler, transitionType: TransitionType.fadeIn);

    router.define('/reviewer',
        handler: _reviewerHandler, transitionType: TransitionType.fadeIn);
  }
}
