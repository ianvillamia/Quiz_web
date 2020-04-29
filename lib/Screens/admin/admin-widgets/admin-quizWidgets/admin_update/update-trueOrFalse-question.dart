import 'package:Quiz_web/Screens/admin/admin-services/adminUpdateQuiz.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/buttonBar.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateTrueOrFalseQuestion extends StatefulWidget {
  final String question;
  final bool answer;
  final DocumentSnapshot doc;

  UpdateTrueOrFalseQuestion({@required this.question, @required this.answer,@required this.doc});
  @override
  _UpdateTrueOrFalseQuestion createState() => _UpdateTrueOrFalseQuestion();
}

class _UpdateTrueOrFalseQuestion extends State<UpdateTrueOrFalseQuestion> {
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
    
    
    return Tooltip(
      message: 'click to update',
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          child: Card(
              child: InkWell(
                splashColor: Colors.blue,
                 onTap: (){
                     UpdateQuizClass().updateQuiz(context: context, type: 'trueOrFalse', doc: widget.doc);
                 },
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
           ExpansionTile(

                    trailing: Icon(Icons.lightbulb_outline),
                    title: Align(alignment: Alignment.bottomRight
          ,child: Text('Show Answer')),
                    children: <Widget>[
          Text('answer is:'+StringUtils.capitalize(widget.answer.toString()),style: TextStyle(
            color: Colors.blue,fontSize: 20
          ),),

                    ],
                  )
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}
