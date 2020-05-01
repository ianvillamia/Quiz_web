import 'package:Quiz_web/Screens/admin/admin-services/adminUpdateQuiz.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IdentificationCard extends StatefulWidget {
  final String question;
  final String answer;
  final DocumentSnapshot doc;

  IdentificationCard({@required this.question, @required this.answer,@required this.doc});

  @override
  _IdentificationCard createState() => _IdentificationCard();
}

class _IdentificationCard extends State<IdentificationCard> {

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    return Tooltip(
      message: 'click to update question',

          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          child: Card(
            child: InkWell(
              splashColor: Colors.blue,
              onTap: (){
                print('clicked');
                UpdateQuizClass().
                  updateQuiz(context: context, type: 'identification', doc: widget.doc);
              },
                        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: Text(StringUtils.capitalize(widget.question)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: 350,
                      child: TextFormField(
                          controller: _controller,
                          onChanged: (text) {
           
                           
                          },
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
                  ),
                ExpansionTile(

                  trailing: Icon(Icons.lightbulb_outline),
                  title: Align(alignment: Alignment.bottomRight
                    ,child: Text('Show Answer')),
                  children: <Widget>[
                    Text('answer is:'+StringUtils.capitalize(widget.answer),style: TextStyle(
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
