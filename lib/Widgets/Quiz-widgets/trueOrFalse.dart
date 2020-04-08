import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/buttonBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrueOrFalse extends StatefulWidget {
  final String question;
  final bool answer;

  TrueOrFalse({@required this.question, @required this.answer});
  @override
  _TrueOrFalseState createState() => _TrueOrFalseState();
}

class _TrueOrFalseState extends State<TrueOrFalse> {
  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(title: Text(widget.question)),
              Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: _quizProvider.trueOrFalseAnswer,
                    onChanged: (val) {
                      _quizProvider.onchangeTrueOrFalse(
                          val: val, correctAnswer: widget.answer.toString());
                    },
                  ),
                  Text(
                    "True",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 2,
                    groupValue: _quizProvider.trueOrFalseAnswer,
                    onChanged: (val) {
                      _quizProvider.onchangeTrueOrFalse(
                          val: val, correctAnswer: widget.answer.toString());
                    },
                  ),
                  Text(
                    "False",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              QuestionBar()
            ],
          ),
        ),
      ),
    );
  }
}
