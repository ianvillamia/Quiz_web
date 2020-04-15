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
    var size=  MediaQuery.of(context).size;

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
    return Container(
      color: Colors.blueGrey,
      height: size.height * .8,
      width: size.width,
      child: Center(
        child: Container(
          width: size.width*.7,
          height: size.height*.5,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Center(
          
           ),
          ),
        ),
      
    );
  }
  
 
}
