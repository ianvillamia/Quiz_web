import 'package:Quiz_web/Services/Providers/quizListProvider.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/quizSubjectTile.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class QuizListBuilder extends StatefulWidget {
  @override
  _QuizListBuilderState createState() => _QuizListBuilderState();
}

class _QuizListBuilderState extends State<QuizListBuilder> {
  @override
  Widget build(BuildContext context) {
    final quizListProvider = Provider.of<QuizListProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * .2,
            child: Container(
              width: MediaQuery.of(context).size.width*.3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: quizListProvider.subjects
                      .map((doc) => subjectItemBuilder(docID: doc))
                      .toList()),
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

  Widget subjectItemBuilder({@required docID}) {
    return QuizSubjectTile(
      docID: docID,
    );
    //call only once
  }
}
