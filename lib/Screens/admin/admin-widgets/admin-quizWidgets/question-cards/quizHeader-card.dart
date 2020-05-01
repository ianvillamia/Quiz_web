import 'package:Quiz_web/Screens/admin/admin-services/adminUpdateQuiz.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class QuizHeaderCard extends StatelessWidget {
 final DocumentSnapshot doc;
  QuizHeaderCard({@required this.doc});


  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Click to update document',
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
                child: InkWell(
                  onTap: ()async{
                    print('clicked dialog');
 await UpdateQuizClass().
                    updateQuiz(context: context, type: 'header', doc: doc);
                  },
                  splashColor: Colors.blue,
                                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
            title: Text(
                      StringUtils.capitalize(doc.data['title']),
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
                      Text(doc.data['hour']==0?'':doc.data['hour'].toString()+' hour and '),
                      Text(doc.data['minute'].toString()+' mins'),
                      
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
        ),
    );
  }
}