import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/question-cards/quizHeader-card.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/adminCreateQuizBody.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/question-cards/identification-card.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/question-cards/multipleChoice-card.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/question-cards/trueOrFalse-card.dart';

class AdminCreateQuiz extends StatefulWidget {
  AdminCreateQuiz({Key key}) : super(key: key);

  @override
  _AdminCreateQuizState createState() => _AdminCreateQuizState();
}

class _AdminCreateQuizState extends State<AdminCreateQuiz> {
  final db = Firestore.instance;
  String collectionName = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //call insert a quiz thing here first
    final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
    //collectionName = _adminProvider.createQuizTitle;
    collectionName = 'quiz1';
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: <Widget>[
          //sidebar
          Container(
            width: size.width * .2,
            height: size.height,
            color: Color.fromRGBO(24, 24, 24, 1),
            child: Center(
                child: Text('Sidebar', style: TextStyle(color: Colors.white))),
          ),
          //body
          Container(
              width: size.width * .8,
              height: size.height,
              child: Stack(
                children: <Widget>[
                  /*Instruction*/
                  Positioned(
                      left: size.width * .02,
                      child: Container(
                        color: Colors.white,
                        width: size.width * .45,
                        height: size.height * .1,
                        child: Center(
                          child: Text('Quiz-Preview'),
                        ),
                      )),
                    //PROGRESS BAR STUFF 
                    Positioned(
                      top:0,
                      child: Container()),
                  /*Preview Screen*/
                  Positioned(
                    top: size.height * .1,
                    left: size.width * .02,
                    child: Container(
                      width: size.width * .45,
                      height: size.height * .9,

                      //here should be the draggable stuff
                      child: StreamBuilder<QuerySnapshot>(
                        stream: db
                            .collection(
                                collectionName) //_quizProvider.currentQuiz
                            .orderBy('order')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Scrollbar(
                              child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: snapshot.data.documents
                                        .map((doc) => quizItemBuilder(
                                            doc: doc, context: context))
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

                  /*Create Quiz tab*/
                  Positioned(right: 0,top: size.height*.1, child: AdminCreateQuizBody())
                ],
              ))
        ],
      ),
    );
  }
  /*QUIZ ITEMBUILDER */

  Widget quizItemBuilder({DocumentSnapshot doc, BuildContext context}) {
    //so hmm ano gagawin ko kailangan i return dito ung data
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    var type = doc.data['type'];
    if (type == 'header') {
      return QuizHeaderCard(doc: doc);
    } else {
      //means not header

      var questionType = doc.data['questionType'];

      if (questionType == 'identification') {
        //admin clickable stuff here
        return IdentificationCard(
            question: doc.data['question'].toString(),
            answer: doc.data['answer'].toString(),
            doc: doc);
      }
      if (questionType == 'multipleChoice') {
        return MultipleChoiceCard(
            choices: doc.data['choices'],
            question: doc.data['question'].toString(),
            answer: doc.data['answer'].toString(),
            doc: doc);
      }
      if (questionType == 'trueOrFalse') {
        return TrueOrFalseCard(
          question: doc.data['question'],
          answer: doc.data['answer'],
          doc: doc,
        );
      }
    }

    return Container();
  }
}
