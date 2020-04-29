import 'package:Quiz_web/Screens/admin/admin-services/adminUpdateQuiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UpdateQuizHeaderCard extends StatelessWidget {
 final DocumentSnapshot doc;
  UpdateQuizHeaderCard({@required this.doc});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
              child: InkWell(
                onTap: (){
 UpdateQuizClass().
                  updateQuiz(context: context, type: 'header', doc: doc);
                },
                splashColor: Colors.blue,
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
        ),
      );
  }
}