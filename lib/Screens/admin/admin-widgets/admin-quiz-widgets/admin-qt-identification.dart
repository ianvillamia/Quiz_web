import 'package:Quiz_web/Services/Providers/quizProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminIdentification extends StatefulWidget {
  final String question;
  final String answer;

  AdminIdentification({@required this.question, @required this.answer});

  @override
  _AdminIdentification createState() => _AdminIdentification();
}

class _AdminIdentification extends State<AdminIdentification> {

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(widget.question),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: 350,
                  child: TextFormField(
                    controller: _controller,
                    onChanged: (text) {
         
                      _quizProvider.answerChecker(
                          userAnswer: _controller.text.trim(), correctAnswer: widget.answer);
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    ),
                    validator: (val) {
                      print('validating:' + val);
                    },
                  ),
                ),
              ),
            ExpansionTile(

              trailing: Icon(Icons.lightbulb_outline),
              title: Align(alignment: Alignment.bottomRight
                ,child: Text('Show Answer')),
              children: <Widget>[
                Text('answer is:'+widget.answer,style: TextStyle(
                  color: Colors.blue,fontSize: 20
                ),),

              ],
            )
             
            ],
          ),
        ),
      ),
    );
  }
}
