import 'package:Quiz_web/Screens/quizScreens/quizListBuilder.dart';

import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:provider/provider.dart';

class AuthenticatedHome extends StatefulWidget {
  @override
  _AuthenticatedHomeState createState() => _AuthenticatedHomeState();
}

class _AuthenticatedHomeState extends State<AuthenticatedHome> {
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
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(25),
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      db.collection('subjectList').orderBy('order').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          Positioned(
            top: 0,
            child: Navbar(),
          ),
        ],
      ),
    );
  }

  Widget quizItemBuilder({DocumentSnapshot doc, BuildContext context}) {
    print(doc.documentID);
    var size = MediaQuery.of(context).size;
    if (doc.data['header_title'] == null) {
      return Container(
        width: size.width * .5,
        child: Card(
          child: InkWell(
            splashColor: Colors.blue,
            onTap: () {
//  give quizID to function
              _onPressedSubject(doc.data['quizzesID']);
            },
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
                    child: Text(doc.data['details'].toString()))
              ],
            ),
          ),
        ),
      );
    } else {
      String headerTitle = StringUtils.capitalize(doc.data['header_title']);
      String headerDetails = StringUtils.capitalize(doc.data['header_details']);
      return Card(
          child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
            headerTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
          ListTile(
              title: Text(
            headerDetails,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ))
        ],
      ));
    }
  }

  void _onPressedSubject(data) {
    print(data);
    //redirect to list of quizzes
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    //updates data of provider to rebuild quizlistBuilder
    _quizProvider.updateSubjects(data); //nagana naman
    //  print(_quizProvider.subjects);
    Navigator.pushNamed(context, '/quizList');
  }
}
