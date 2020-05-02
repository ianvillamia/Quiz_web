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
  void initState() {
    // TODO: implement initState
    super.initState();
    final _adminProvider = Provider.of<AdminProvider>(context,listen: false);
     Firestore.instance
        .collection('quizToSubjects')
        .where('title', isEqualTo:_adminProvider.currentQuiz)
        .limit(1)
        .snapshots()
        .listen((data) async {
      data.documents.forEach((doc) async {
        _adminProvider.quizToSubjects = doc.data['subjects'];
        //add thing to provider --update
        _adminProvider.quizToSubjectID=doc.documentID;
        
        //eto document id nung stuff

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection('subjectList') //_quizProvider.currentQuiz
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
  Widget checkBoxItem({doc}) {
    String subjectTitle = doc.data['title'];
    final _adminProvider = Provider.of<AdminProvider>(context);
    for (var item in _adminProvider.quizToSubjects) {
      if (subjectTitle == item) {
      //  print('subjectTItle:$subjectTitle--item:$item---same');
        return SubjectCheckBox(title: subjectTitle, isSelected: true,doc: doc,);
      }
    }
    return SubjectCheckBox(title: subjectTitle, isSelected: false,doc: doc,);
    //irereturn neto 2 times chitae
  }
}
