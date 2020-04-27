import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-dialogs.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/adminCreateQuizBody.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/identification.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/multipleChoice.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/trueOrFalse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
 collectionName = _adminProvider.createQuizTitle;
  //collectionName ='quiz1';
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
              color: Color.fromRGBO(235, 236, 240, 1),
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
                  /*Preview Screen*/
                  Positioned(
                    top: size.height * .1,
                    left: size.width * .02,
                    child: Container(
                      width: size.width * .45,
                      height: size.height * .9,
                      color: Color.fromRGBO(254, 175, 98, 1),
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
                                        .map((doc) => IgnorePointer(
                                              ignoring: true,
                                              child: quizItemBuilder(
                                                  doc: doc, context: context),
                                            ))
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
                  Positioned(
                      right: 0,
                      child: AdminCreateQuizBody())
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
                  doc.data['title'].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(doc.data['instructions'].toString())),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
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
                        Text(
                          doc.data['creator'].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ))
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
