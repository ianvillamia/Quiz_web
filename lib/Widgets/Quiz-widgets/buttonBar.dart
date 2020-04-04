import 'package:flutter/material.dart';
class QuestionBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  
    return ButtonBar(
      children: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.lightbulb_outline),
          label: Text('View Answer'),
          onPressed: () {/* ... */},
        ),
        FlatButton(
          child: const Text('Report'),
          onPressed: () {/* ... */},
        ),
      ],
    );
  
  }
}