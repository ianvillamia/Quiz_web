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
  int selected;
  
  @override
  Widget build(BuildContext context) {


    final _quizProvider = Provider.of<QuizProvider>(context,listen: false);
     changeSelectedValue(int val) {
      setState(() {
        selected = val;
       _quizProvider.onchangeTrueOrFalse(val: selected, correctAnswer: widget.answer.toString());
      });
    }
    
    
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
                    groupValue: selected,
                    onChanged: (val) {
                 changeSelectedValue(val);
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
                    groupValue: selected,
                    onChanged: (val) {
                               changeSelectedValue(val);
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
