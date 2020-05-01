import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/question-cards/quizHeader-card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/question-cards/identification-card.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/question-cards/multipleChoice-card.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/question-cards/trueOrFalse-card.dart';

class UpdateQuizBuilder extends StatelessWidget {
  final String collectionID;
  UpdateQuizBuilder({@required this.collectionID});
  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection(collectionID) //_quizProvider.currentQuiz
          .orderBy('order')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data.documents
                      .map((doc) => quizItemBuilder(doc: doc, context: context))
                      .toList()),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget quizItemBuilder({DocumentSnapshot doc, BuildContext context}) {
  //so hmm ano gagawin ko kailangan i return dito ung data
  //eto dito ako gagawa ..
  var type = doc.data['type'];
  if (type == 'header') {
    //header
    //   _quizProvider.countInit();
    return QuizHeaderCard(
      doc: doc,
    );
    //add init counter
  } else {
    //means not header

    var questionType = doc.data['questionType'];

    if (questionType == 'identification') {
      return IdentificationCard(
        doc: doc,
        question: doc.data['question'],
        answer: doc.data['answer'],
      );
    }
    if (questionType == 'multipleChoice') {
      return MultipleChoiceCard(
        doc: doc,
        question: doc.data['question'],
        choices: doc.data['choices'],
        answer: doc.data['answer'],
      );
    }
    if (questionType == 'trueOrFalse') {
      return TrueOrFalseCard(
          doc: doc, question: doc.data['question'], answer: doc.data['answer']);
    }
  }

  return Container();
}
