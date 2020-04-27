import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultipleChoice extends StatefulWidget {
  final List choices;
  final String question;
  final String answer;

  MultipleChoice(
      {@required this.choices, @required this.question, @required this.answer});

  @override
  _MultipleChoiceState createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  int selected;
  String userAnswer;

  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
     changeSelectedValue(int val) {
      setState(() {
        selected = val;
        getUserAnswer(value: selected);
        _quizProvider.onChangeMultipleChoice(
                          correctAnswer: widget.answer, userAnswer: userAnswer);
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(widget.question),
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: selected,
                    onChanged: (val)  {
                      changeSelectedValue(val);
                      
                    },
                  ),
                  Text(
                    widget.choices[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 2,
                    groupValue: selected,
                    onChanged: (val) async {
                      changeSelectedValue(val);
                  
                    },
                  ),
                  Text(
                    widget.choices[1],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 3,
                    groupValue: selected,
                    onChanged: (val) async {
                      changeSelectedValue(val);
                    }
                  ),
                  Text(
                    widget.choices[2],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 4,
                    groupValue: selected,
                    onChanged: (val) async {
                      changeSelectedValue(val);
                     
                    },
                  ),
                  Text(
                    widget.choices[3],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
                ExpansionTile(

              trailing: Icon(Icons.lightbulb_outline),
              title: Align(alignment: Alignment.bottomRight
                  ,child: Text('Show Answer')),
              children: <Widget>[
                  Text('answer is:'+widget.answer,style: TextStyle(
                    color: Colors.blue,fontSize: 20
                  ),),

              ],
            )
            ],
          ),
        ),
      ),
    );
  }

  getUserAnswer({int value}) {

    switch (value) {
      case 1:
        userAnswer = widget.choices[0];
        break;
      case 2:
        userAnswer = widget.choices[1];
        break;
      case 3:
        userAnswer = widget.choices[2];
        break;
      case 4:
        userAnswer = widget.choices[3];
        break;
    }
  
  }
}
