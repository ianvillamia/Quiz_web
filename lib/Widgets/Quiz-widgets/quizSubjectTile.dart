import 'package:Quiz_web/Services/Firebase/Firestore/quizSubjectTIleService.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class QuizSubjectTile extends StatefulWidget {
  final docID;
  QuizSubjectTile({@required this.docID});

  @override
  _QuizSubjectTileState createState() => _QuizSubjectTileState();
}

class _QuizSubjectTileState extends State<QuizSubjectTile> {
  var title='';
  var details='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Firestore.instance
    .collection('quiz1')
    .where("order", isEqualTo: 0)
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

    return Card(
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {
          print('Card tapped.');
        },
        child: Column(
          children: <Widget>[
            ListTile(title: Text(title),),
            ListTile(title: Text(details),)
          ],
        )
      ),
    );
  }
}