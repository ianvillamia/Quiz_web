import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/buttonBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Identification extends StatefulWidget {
  final String question;
  final String answer;

  Identification({@required this.question, @required this.answer});

  @override
  _IdentificationState createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification> {

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(widget.question),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: 350,
                  child: TextFormField(
                    controller: _controller,
                    onChanged: (text) {
                
                      _quizProvider.answerChecker(
                          userAnswer: _controller.text, correctAnswer: widget.answer);
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    ),
                    validator: (val) {
                      print('validating:' + val);
                    },
                  ),
                ),
              ),
              QuestionBar()
            ],
          ),
        ),
      ),
    );
  }
}
