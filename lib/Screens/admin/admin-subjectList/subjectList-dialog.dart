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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    potato();
  }
  final db = Firestore.instance;

potato(){
    //getting document id of subject  
    final _adminProvider = Provider.of<AdminProvider>(context,listen: false);
     Firestore.instance
        .collection('quizList')
        .where('title', isEqualTo:_adminProvider.currentQuiz)
        .limit(1)
        .snapshots()
        .listen((data) async {
      data.documents.forEach((doc) async {
        _adminProvider.updateQuizSubjects(subjects: doc.data['subjects'], id: doc.documentID.toString());
       
        
        //eto document id nung stuff

      });
    });
}

  @override
  Widget build(BuildContext context) {
    potato();
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
    final _adminProvider = Provider.of<AdminProvider>(context,listen: false);
    print('so checkbox is');
    print(_adminProvider.quizSubjects);
    for (var item in _adminProvider.quizSubjects) {
      if (subjectTitle == item) {
      //  print('subjectTItle:$subjectTitle--item:$item---same');
        return SubjectCheckBox(title: subjectTitle, isSelected: true,doc: doc,);
      }
    }
   return SubjectCheckBox(title: subjectTitle, isSelected: false,doc: doc,);
   // irereturn neto 2 times chitae
  //return Container();
  }
}
