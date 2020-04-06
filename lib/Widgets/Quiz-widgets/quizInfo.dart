import 'package:flutter/material.dart';

class QuizInfo extends StatelessWidget {
  final String quizTitle;
  final String quizInstructions;
  final String quizCreator;

  QuizInfo({@required this.quizTitle,@required this.quizInstructions,@required this.quizCreator});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            quizHeader(text: quizTitle),
            SizedBox(
              height: 10,
            ),
            Text(quizInstructions),
            Text('Created by: '+quizCreator)
          ],
        ),
      ),
    );
  }
  quizHeader({String text}){
    return Text(
      text,style: TextStyle(
        fontSize: 25,fontWeight: FontWeight.bold
      ),
    );
  }

}