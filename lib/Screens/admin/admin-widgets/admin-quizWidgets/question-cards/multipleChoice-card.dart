import 'package:Quiz_web/Screens/admin/admin-services/adminUpdateQuiz.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultipleChoiceCard extends StatefulWidget {
  final List choices;
  final String question;
  final String answer;
  final DocumentSnapshot doc;
  MultipleChoiceCard(
      {@required this.choices,
      @required this.question,
      @required this.answer,
      @required this.doc});

  @override
  _MultipleChoiceCard createState() =>
      _MultipleChoiceCard();
}

class _MultipleChoiceCard
    extends State<MultipleChoiceCard> {
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

    return Tooltip(
      message: 'click to update question',
          child: Tooltip(
            message: 'click to update question',
                      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
            width: MediaQuery.of(context).size.width * .8,
            child: Card(
              child: InkWell(
                splashColor: Colors.blue,
                onTap: (){
                  UpdateQuizClass()
                    .updateQuiz(context: context, type: 'multipleChoice', doc: widget.doc);
                },
                              child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(StringUtils.capitalize(widget.question)),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: selected,
                          onChanged: (val) {
                            changeSelectedValue(val);
                          },
                        ),
                        Text(
                          StringUtils.capitalize(
                            widget.choices[0],
                          ),
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
                          StringUtils.capitalize(
                            widget.choices[1],
                          ),
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
                            }),
                        Text(
                          StringUtils.capitalize(
                            widget.choices[2],
                          ),
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
                          StringUtils.capitalize(
                            widget.choices[3],
                          ),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      trailing: Icon(Icons.lightbulb_outline),
                      title: Align(
                          alignment: Alignment.bottomRight,
                          child: Text('Show Answer')),
                      children: <Widget>[
                        Text(
                          'answer is:' + StringUtils.capitalize(widget.answer)
                          ,
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
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
