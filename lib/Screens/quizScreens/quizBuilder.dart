import 'package:Quiz_web/Widgets/Quiz-widgets/identification.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/multipleChoice.dart';

import 'package:Quiz_web/Widgets/Quiz-widgets/timer.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/trueOrFalse.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';

class QuizBuilder extends StatelessWidget {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * .2,
            child: Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .7,
              child: StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('quiz1') //_quizProvider.currentQuiz
                    .orderBy('order')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: snapshot.data.documents
                                .map((doc) =>
                                    quizItemBuilder(doc: doc, context: context))
                                .toList()),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Navbar(),
          ),
          //create a submit button 
          Positioned(
              top: MediaQuery.of(context).size.height * .5,
              right: 0,
              child: Timer())
        ],
      ),
    );
  }

  Widget quizItemBuilder({DocumentSnapshot doc, BuildContext context}) {
    //so hmm ano gagawin ko kailangan i return dito ung data
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    var type = doc.data['type'];
    if (type == 'header') {
      //header
      //   _quizProvider.countInit();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                    title: Text(
                  doc.data['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(doc.data['instructions'].toString())),
                    Padding(
                    padding: EdgeInsets.all(15),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       Row(
                         children: <Widget>[
                           Text('Time allotted:'),
                           Text('15 mins')
                         ],
                       ),
                       SizedBox(
                         height: 5,
                       ),
                        Text('Created By:'),
                         Text(doc.data['creator'].toString(),style: TextStyle(
                           fontWeight: FontWeight.bold
                         ),)
                      ],
                    ) )   
              ],
            ),
          ),
        ),
      );
      //add init counter
    } else {
      //means not header

      var questionType = doc.data['questionType'];

      if (questionType == 'identification') {
        return Identification(
          question: doc.data['question'],
          answer: doc.data['answer'],
        );
      }
      if (questionType == 'multipleChoice') {
        return MultipleChoice(
          question: doc.data['question'],
          choices: doc.data['choices'],
          answer: doc.data['answer'],
        );
      }
      if (questionType == 'trueOrFalse') {
        return TrueOrFalse(
            question: doc.data['question'], answer: doc.data['answer']);
      }
    }

    return Container();
  }
}
