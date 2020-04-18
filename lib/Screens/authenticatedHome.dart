import 'package:Quiz_web/Widgets/Quiz-widgets/identification.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/multipleChoice.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/quizInfo.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/timer.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/trueOrFalse.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';

class AuthenticatedHome extends StatefulWidget {
  @override
  _AuthenticatedHomeState createState() => _AuthenticatedHomeState();
}

class _AuthenticatedHomeState extends State<AuthenticatedHome> {
  bool initCounter = true;

  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
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
                stream: db.collection('subjectList').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                            children: snapshot.data.documents
                                .map((doc) => quizItemBuilder(doc: doc,
                                context: context))
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
        
        ],
      ),
    );
  }

  Widget quizItemBuilder({DocumentSnapshot doc,BuildContext context}) {
    print(doc.documentID);
  var size = MediaQuery.of(context).size;
    return Container(
      width: size.width*.5,
      child: Card(
        
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(doc.data['title'].toString()),
            ),
            Text(doc.data['details'].toString())
          ],
        ),
      ),
    );
  }
}
