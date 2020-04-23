import 'dart:async';

import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:provider/provider.dart';

class QuizScore extends StatefulWidget {
  QuizScore({Key key}) : super(key: key);

  @override
  _QuizScoreState createState() => _QuizScoreState();
}

class _QuizScoreState extends State<QuizScore> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(top: size.height * .2, child: scoreCard(size)),
          Positioned(
            top: 0,
            child: Navbar(),
          ),
        ],
      ),
    );
  }

  scoreCard(size) {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(229, 229, 229, 1),
        height: size.height * .8,
        width: size.width,
        child: Center(
          child: Container(
            width: size.width * .7,
            height: size.height * .5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              
                children: <Widget>[
                  Text(
                    'Your score is',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    '15/20',
                    style: TextStyle(fontSize: 25),
                  ),
                  //what you got right
                  Container(
                    color: Color.fromRGBO(78, 195, 117, 1),
                    height: 50,
                    child: Center(
                      child: Text('What you got Right',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  itembuilder(),
                  Container(
                    color: Colors.redAccent,
                    height: 50,
                    child: Center(
                      child: Text('What you got Wrong',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ) //what you got wrong
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  itembuilder() {
    return Container(
      width: MediaQuery.of(context).size.width*.7,
   
      child: Padding(
          padding: EdgeInsets.all(10),
          
          child: Column(
            children: <Widget>[
               Row(
                 children: <Widget>[
                   Text('Question:'),
       
                   Text('What color is the sun?')
                 ],
               ) ,
            ],
          )),
    );
  }
}
