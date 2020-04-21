
import 'package:Quiz_web/Screens/quizScreens/quizSubjectTile.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class QuizListBuilder extends StatefulWidget {
  @override
  _QuizListBuilderState createState() => _QuizListBuilderState();
}

class _QuizListBuilderState extends State<QuizListBuilder> {
  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * .2,
            child: Container(
              width: MediaQuery.of(context).size.width*.3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _quizProvider.subjects
                      .map((doc) => subjectItemBuilder(subject: doc))
                      .toList()),
            ),
          ),
          Positioned(
            top: 0,
            child: Navbar(),
          ),
        ],
      ),
    );
  }

  Widget subjectItemBuilder({@required subject}) {
    //get some stateful widget that runs the quiz builder 
    return QuizSubjectTile(
      collectionID: subject,
    );
    //call only once
  }
}
