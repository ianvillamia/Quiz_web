import 'package:Quiz_web/Models/userModel.dart';
import 'package:Quiz_web/Screens/home.dart';


import 'package:Quiz_web/Screens/quizScore.dart';
import 'package:Quiz_web/Screens/flipCards.dart';
import 'package:Quiz_web/Screens/quizScreens/quizBuilder.dart';
import 'package:Quiz_web/Screens/reviewer.dart';

import 'package:Quiz_web/Widgets/pageBuilder.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var currentPage = '/authenticatedHome';

  final loading = false;

  //AuthenticationService auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


    if (user == null) {
      //not signed in

      //eto testing area
      //return home with login signup
      //return QuizBuilder();
  //return Reviewer();
      return QuizBuilder();
    //  return Home();
    } else {
      //return pagebuilder
      return PageBuilder(page: currentPage);
    }
  }
}


