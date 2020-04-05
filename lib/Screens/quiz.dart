import 'package:Quiz_web/Widgets/Quiz-widgets/fillInTheBlanks.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/identification.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/multipleChoice.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/trueOrFalse.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/quiz-Items.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
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
              child: ListView(
                children: <Widget>[
                  MultipleChoice(
                    choices: ["Choice1", "Choice2", "Choice3", "Choice4"],
                    question: "What does the Fox say",
                  ),
                  Identification(
                      question:
                          "What does the Dog Say?What does the Dog Say?What does the Dog Say?What does the Dog Say?"),
                  FillInTheBlank(
                    leadingQuestion:
                        "First This is the QUestion before a TextBox",
                    afterQuestion: "This is the second after the TextBox",
                  ),
                  TrueOrFalse(
                    question: "Is the World Round?",
                  )
                ],
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
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
              child: Center(
                child: SlideCountdownClock(
                  duration: Duration(minutes: 1),
                  slideDirection: SlideDirection.Down,
                  separator: ":",
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  onDone: () {
                    // do routing
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
