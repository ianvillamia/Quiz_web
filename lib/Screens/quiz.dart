import 'package:Quiz_web/Widgets/Quiz-widgets/fillInTheBlanks.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/identification.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/multipleChoice.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/trueOrFalse.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/quiz-Items.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

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
            right: 50,
            child: Container(
              width: 100,
              //color: Colors.red,
              child: Column(
                children: <Widget>[
               
                  LiteRollingSwitch(
                    //initial value
                    value: true,
                    textOn: 'Timer on',
                    textOff: 'Timer off',
                    colorOn: Colors.greenAccent[700],
                    colorOff: Colors.redAccent[700],
                    iconOn: Icons.alarm_on,
                    animationDuration: Duration(seconds:1),
                    iconOff: Icons.alarm_off,
                    textSize: 10.0,
                    onChanged: (bool state) {
                      //Use it to manage the different states
                      print('Current State of SWITCH IS: $state');
                    },
                  ),

                     SlideCountdownClock(
                    duration: Duration(minutes: 1),
                    slideDirection: SlideDirection.Down,
                    separator: ":",
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    onDone: () {
                      // do routing
                      print('tapos ka na mag quiz noob');
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
