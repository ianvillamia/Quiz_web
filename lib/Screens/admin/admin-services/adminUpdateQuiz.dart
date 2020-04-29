import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/admin_update/update-question-dialogs/update-identification-dialog.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/admin_update/update-question-dialogs/update-multipleChoice-dialog.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/admin_update/update-question-dialogs/update-trueOrFalse-dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quizWidgets/admin_update/update-question-dialogs/update-header-dialog.dart';
class UpdateQuizClass {
  /*UPDATE DOC*/
  updateQuiz({BuildContext context, String type, DocumentSnapshot doc}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Text("Update Document"),
              Text(
                'please update the values you want to change',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
          content: Container(
            width: size.width * .5,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                    child:
                        customBuilder(type: type, doc: doc, context: context)),
              ),
            ),
          ),
          actions: [],
        );
      },
    );
  }

  customBuilder({String type, DocumentSnapshot doc, BuildContext context}) {
    //*************************************************************************//
    if (type == 'identification') {
      return UpdateIdentificationDialog(doc: doc);
    }

    //***********************************************************************//
    if (type == 'multipleChoice') {
      return UpdateMultipleChoiceDialog(doc: doc);
      //insert update thing here
    }
    //***********************************************************************//

    if (type == 'trueOrFalse') {
      return UpdateTrueOrFalseDialog(doc: doc);
    }
    //***********************************************************************//
    if (type == 'header') {
      return UpdateHeaderDialog(doc: doc);
    }
  }
}
