import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';

class Quiz extends StatelessWidget {
  const Quiz({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[Navbar(), Center(child: Text('Quiz works'))],
        ),
      ),
    );
  }
}
