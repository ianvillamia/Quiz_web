import 'package:Quiz_web/Services/Firebase/Firestore/quizSubjectTIleService.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class QuizSubjectTile extends StatefulWidget {
  final collectionID;
  QuizSubjectTile({@required this.collectionID});

  @override
  _QuizSubjectTileState createState() => _QuizSubjectTileState();
}

class _QuizSubjectTileState extends State<QuizSubjectTile> {
  var title = '';
  var details = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get quiz1
   Firestore.instance
    .collection(widget.collectionID)
    .where('type',isEqualTo: 'header')
    .snapshots()
    .listen((data) =>
        data.documents.forEach((doc) {
          setState(() {
            title=doc['title'];
            details=doc['instructions'];
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    return Card(
      child: InkWell(
          splashColor: Colors.blue,
          onTap: () {
            print('Card tapped.');
            _quizProvider.updateCurrentQuiz(data: widget.collectionID.toString());
            Navigator.pushNamed(context, '/quiz');
          },
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(title),
              ),
              ListTile(
                title: Text(details),
              )
            ],
          )),
    );
  }
}
