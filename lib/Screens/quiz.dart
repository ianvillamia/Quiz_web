import 'package:Quiz_web/Services/Firestore/quizService.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/fillInTheBlanks.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/identification.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/multipleChoice.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/quizInfo.dart';

import 'package:Quiz_web/Widgets/Quiz-widgets/timer.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/trueOrFalse.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/quiz-Items.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Quiz_web/Services/routing.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool initCounter = true;
  final db = Firestore.instance;
  QuizItems quizItems = QuizItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * .2,
            child: Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection('quiz1').orderBy('order').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Scrollbar(
                      child: ListView(
                          children: snapshot.data.documents
                              .map((doc) => quizItemBuilder(doc: doc))
                              .toList()),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Navbar(),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * .5,
              right: 0,
              child: Timer())
        ],
      ),
    );
  }

  Widget quizItemBuilder({DocumentSnapshot doc}) {
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    var type = doc.data['type'];
    print(doc.documentID);
    if (_quizProvider.isInit && type == "header") {
      _quizProvider.isInit = false;
      return QuizInfo(
        quizTitle: doc.data['title'],
        quizInstructions: doc.data['instructions'],
        quizCreator: doc.data['creator'],
      );
    } else {
      // print(type);
      var questionType = doc.data['questionType'];
      // print(questionType);
      if (questionType == 'identification') {
        return Identification(question: doc.data['question'],answer: doc.data['answer'],);
      }
      if (questionType == 'multipleChoice') {
        // print(questionType);
        return MultipleChoice(
          question: doc.data['question'],
          choices: doc.data['choices'],
        );
      }
      if(questionType=='trueOrFalse'){
        return TrueOrFalse(
          question: doc.data['question'],
          answer: doc.data['answer']
        );
      }
    }

    return Container();
  }
}
