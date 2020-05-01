import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-subjectList/admin-subjectCheckbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectListDialog extends StatefulWidget {
  @override
  _SubjectListDialogState createState() => _SubjectListDialogState();
}

class _SubjectListDialogState extends State<SubjectListDialog> {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final _adminProvider = Provider.of<AdminProvider>(context,listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection('quizToSubjects').where('title',isEqualTo: _adminProvider.currentQuiz) //_quizProvider.currentQuiz
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data.documents
                      .map((doc) => checkBoxItem(doc: doc))
                      .toList()),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
  //
  Widget checkBoxItem({doc}){
    print(doc.data['subjects']);
    return Container();
  }
}
