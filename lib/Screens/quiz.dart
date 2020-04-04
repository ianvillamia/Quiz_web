import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/quiz-Items.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key key}) : super(key: key);

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  QuizItems quizItems =QuizItems();
  int selectedRadio;
  setSelectedRadio(int value) {
    setState(() {
      selectedRadio = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            
            children: <Widget>[
              SizedBox(
                height: 110,
              ),
        
  quizItems.multipleChoice(context),
  quizItems.identification(context,question: "SOME QUESTION"),
  quizItems.trueOrFalse(context),
  quizItems.fillInTheBlank()
            ],
          ),
          Positioned(
            top: 0,
            child: Navbar(),
          ),
        ],
      ),
    );
  }

 


}
