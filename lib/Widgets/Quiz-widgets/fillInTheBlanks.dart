import 'package:Quiz_web/Widgets/Quiz-widgets/buttonBar.dart';
import 'package:flutter/material.dart';

class FillInTheBlank extends StatelessWidget {
  final String leadingQuestion;
  final String afterQuestion;
  FillInTheBlank({this.leadingQuestion,this.afterQuestion});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
            child: Card(
                child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
          children: <Widget>[
            Text(leadingQuestion), 
            SizedBox(width: 10,),
            Container(
              width: 150,
              child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
              ),
            ),
            Text(afterQuestion),
          ],
        ),
                              ),
      QuestionBar()
                            ],
                ))));
  }
}