import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class QuizLoader extends StatefulWidget {
  const QuizLoader({Key key}) : super(key: key);

  @override
  _QuizLoaderState createState() => _QuizLoaderState();
}

class _QuizLoaderState extends State<QuizLoader> {
  void doSomeLoading(){
    Future.delayed(Duration(seconds: 2),(){
    Navigator.pushNamed(context, '/quizScore');
    });

  }

  @override
  void initState() { 
    super.initState();
    doSomeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: SpinKitChasingDots(
            color: Colors.white,
            size: 50,
          ),
      ),
    );
  }
}