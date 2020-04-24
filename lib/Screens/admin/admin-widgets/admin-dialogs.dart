import 'package:Quiz_web/Screens/admin/admin-providers/adminSubjectProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminAlertDialogs {
  final _formKey = GlobalKey<FormState>();
  addSubjectDialog(BuildContext context) {
    TextEditingController subjectController = TextEditingController(),
        detailsController = TextEditingController();

    final adminSubjectProvider =
        Provider.of<AdminSubjectProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text(
            "Add a Subject",
          ),
          content: Form(
              key: _formKey,
              child: Container(
                height: size.height * .25,
                width: size.width * .5,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: subjectController,
                        decoration: InputDecoration(
                            labelText: "Subject", hintText: 'enter subject'),
                        validator: (val) {
                          // print('validating');
                          if (val.length <= 0) {
                            adminSubjectProvider
                                .changeErrorString('must not be empty');
                          }
                          return adminSubjectProvider.errorText;
                        }),
                    TextFormField(
                        controller: detailsController,
                        decoration: InputDecoration(
                            labelText: "Details", hintText: 'enter details'),
                        validator: (val) {
                          // print('validating');
                          if (val.length <= 0) {
                            return 'must not be empty';
                          } else {
                            return null;
                          }
                        }),
                  ],
                ),
              )),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () async {
                await checkDuplicates(
                        subjectController.text.toLowerCase().trim())
                    .then((val) {
                  if (val == true) {
                    print('duplicate values');

                    adminSubjectProvider.changeErrorString('duplicate values');
                  } else {
                    adminSubjectProvider.checkSubject(true);
                    print('ok values');
                    adminSubjectProvider.changeErrorString(null);
                    AdminService()
                        .addSubject(
                            subject: subjectController.text,
                            details: detailsController.text)
                        .then((value) => print('success'));
                    Navigator.pop(context);
                  }
                }).catchError((onError) {});
                if (_formKey.currentState.validate()) {}
              },
            )
          ],
        );
      },
    );
  }

  Future<bool> checkDuplicates(String subject) async {
    try {
      final QuerySnapshot result = await Firestore.instance
          .collection('subjectList')
          .where('title', isEqualTo: subject)
          .limit(1)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      return documents.length == 1;
    } catch (err) {}
  }

  ///*update dialogsss *///
  updateSubjectDialog({BuildContext context, DocumentSnapshot doc}) {
    TextEditingController subjectController = TextEditingController(),
        detailsController = TextEditingController();
    var docID = doc.documentID.toString();
    final adminSubjectProvider =
        Provider.of<AdminSubjectProvider>(context, listen: false);
    String title = StringUtils.capitalize(doc.data['title'].toString());
    String details = StringUtils.capitalize(doc.data['details'].toString());
    subjectController.text = title;
    detailsController.text = details;
    bool isEditable = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Update a Subject",
              ),
            ],
          ),
          content: Form(
              key: _formKey,
              child: Container(
                height: size.height * .25,
                width: size.width * .5,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        enabled: adminSubjectProvider.editable,

                        // initialValue: title,
                        controller: subjectController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        validator: (val) {
                          // print('validating');
                          if (val.length <= 0) {
                            adminSubjectProvider
                                .changeErrorString('must not be empty');
                          }
                          return adminSubjectProvider.errorText;
                        }),
                    TextFormField(
                        enabled: adminSubjectProvider.editable,
                        //initialValue: details,
                        controller: detailsController,
                        decoration: InputDecoration(
                          labelText: 'Details',
                        ),
                        validator: (val) {
                          // print('validating');
                          if (val.length <= 0) {
                            return 'must not be empty';
                          } else {
                            return null;
                          }
                        }),
                  ],
                ),
              )),
          actions: [
            FlatButton(
              child: Text("Update"),
              onPressed: () async {
                
                if (_formKey.currentState.validate()) {
                   AdminService().updateSubject(
                        subject: subjectController.text.trim(),
                        details: detailsController.text.trim(),
                        docID: docID);

                    Navigator.pop(context);
                }
              },
            )
          ],
        );
      },
    );
  }
}
