import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
class QuizScore extends StatefulWidget {
  QuizScore({Key key}) : super(key: key);

  @override
  _QuizScoreState createState() => _QuizScoreState();
}

class _QuizScoreState extends State<QuizScore> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: Stack(
        children: <Widget>[
        
          Positioned(
            top: MediaQuery.of(context).size.height * .2,
            child: Container(
              color: Colors.blueGrey,
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width,
            
            ),
          ),
          Positioned(
            top: 0,
            child: Navbar(),
          ),
       
        ],
      ),
    );
  }
}