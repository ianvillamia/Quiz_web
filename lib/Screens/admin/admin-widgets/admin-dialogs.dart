import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:Quiz_web/Screens/admin/adminScreens/adminSubjects.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/identification.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/multipleChoice.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/trueOrFalse.dart';
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
        Provider.of<AdminProvider>(context, listen: false);
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
            FlatButton.icon(
              icon: Icon(Icons.add),
              color: Colors.green,
              label: Text("ADD"),
              onPressed: () async {
                await checkDuplicates(
                        subject: subjectController.text.toLowerCase().trim(),
                        collection: 'subjectList')
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

  Future<bool> checkDuplicates(
      {@required String subject, @required String collection}) async {
    try {
      final QuerySnapshot result = await Firestore.instance
          .collection(collection)
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
        Provider.of<AdminProvider>(context, listen: false);
    String title = StringUtils.capitalize(doc.data['title'].toString());
    String details = StringUtils.capitalize(doc.data['details'].toString());
    subjectController.text = title;
    detailsController.text = details;

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
            FlatButton.icon(
              icon: Icon(Icons.delete),
              label: Text("Delete"),
              color: Colors.red,
              onPressed: () async {
                //create dapat ng dialog do you really want to delete?
                await doYouWantToDeleteDialog(
                    context: context, docID: docID, type: 'subject');
              },
            ),
            SizedBox(
              width: size.width * .35,
            ),
            FlatButton.icon(
              icon: Icon(Icons.update),
              label: Text(
                "Update",
              ),
              color: Colors.greenAccent,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  AdminService().updateSubject(
                      subject: subjectController.text.trim(),
                      details: detailsController.text.trim(),
                      docID: docID);

                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  doYouWantToDeleteDialog(
      {@required BuildContext context,
      @required String docID,
      @required String type}) {
    TextEditingController confirmController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _adminProvider = Provider.of<AdminProvider>(context);
        var size = MediaQuery.of(context).size;
        return AlertDialog(
          titlePadding: EdgeInsets.all(0),
          title: Container(
            width: size.width * .5,
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width*.5,
                  height: size.height*.1,
                    color: Color.fromRGBO(255, 82, 82, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Do you really want to delete this $type?",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text('Doing so will permanently delete the $type',style: TextStyle(
                            fontSize: 12,color: Colors.white
                          ),)
                        ],
                      ),
                    )),
                ListTile(
                  title: TextFormField(
                    controller: confirmController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: docID,
                        labelText: 'Please type $docID below to confirm'),
                    onChanged: (val) {
                      if (confirmController.text == docID) {
                        _adminProvider.toggleDeleteButton(true);
                      } else {
                        _adminProvider.toggleDeleteButton(false);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          actions: [
            Visibility(
              visible: _adminProvider.isDeleteButtonVisible,
              child: Row(
                children: <Widget>[
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () async {
                      if (type.toLowerCase() == 'subject') {
                        await AdminService()
                            .deleteSubject(docID: docID)
                            .then((value) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }
                      if (type.toLowerCase() == 'quiz') {
                        await AdminService()
                            .deleteQuiz(collectionID: docID)
                            .then((value) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }
                    },
                  ),
                  FlatButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        );
        ;
      },
    );
  }

  createQuizDialog(BuildContext context) {
    TextEditingController quizTitleController = TextEditingController(),
        instructionsController = TextEditingController(),
        timeAllottedController = TextEditingController(),
        creatorController = TextEditingController();

    final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        return AlertDialog(
          title: Text(
            "Create a Quiz",
          ),
          content: Form(
              key: _formKey,
              child: Container(
                height: size.height * .8,
                width: size.width * .6,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          controller: quizTitleController,
                          decoration: InputDecoration(
                              labelText: "Quiz Title",
                              hintText: 'enter subject'),
                          validator: (val) {
                            // print('validating');
                            if (val.length <= 0) {
                              _adminProvider
                                  .changeErrorString('must not be empty');
                            }
                            return _adminProvider.errorText;
                          }),
                      TextFormField(
                          controller: instructionsController,
                          decoration: InputDecoration(
                              labelText: "Instructions",
                              hintText: 'enter details'),
                          validator: (val) {
                            // print('validating');
                            if (val.length <= 0) {
                              return 'must not be empty';
                            } else {
                              return null;
                            }
                          }),
                      TextFormField(
                          controller: timeAllottedController,
                          decoration: InputDecoration(
                              labelText: "time alloted",
                              hintText: 'enter details'),
                          validator: (val) {
                            // print('validating');
                            if (val.length <= 0) {
                              return 'must not be empty';
                            } else {
                              return null;
                            }
                          }),
                      TextFormField(
                          controller: creatorController,
                          decoration: InputDecoration(
                              labelText: "Creator Name",
                              hintText: 'enter details'),
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
                ),
              )),
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.forward),
              color: Colors.green,
              label: Text("NEXT"),
              onPressed: () async {
                await checkDuplicates(
                        subject: quizTitleController.text.toLowerCase().trim(),
                        collection: 'quizList')
                    .then((val) {
                  if (val == true) {
                    print('duplicate values');

                    _adminProvider.changeErrorString('duplicate quiz');
                  } else {
                    _adminProvider.checkSubject(true);
                    print('potato values');
                    AdminService()
                        .createQuiz(
                            context: context,
                            title: quizTitleController.text,
                            creator: creatorController.text,
                            instructions: instructionsController.text,
                            time: timeAllottedController.text)
                        .then((value) {
                      final _adminProvider =
                          Provider.of<AdminProvider>(context, listen: false);
                      _adminProvider.setQuizTitle(quizTitleController.text);
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/adminCreateQuiz');
                    }).catchError((err) {
                      print('errorbano');
                    });
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

  showQuiz(BuildContext context, String collectionID) {
    final db = Firestore.instance;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("QuizPreview"),
          content: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * .5,
            child: StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection(collectionID) //_quizProvider.currentQuiz
                  .orderBy('order')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: snapshot.data.documents
                              .map((doc) =>
                                  quizItemBuilder(doc: doc, context: context))
                              .toList()),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  //add service to delete pass in collection id
                  await doYouWantToDeleteDialog(
                      context: context, docID: collectionID, type: 'quiz');
                },
                icon: Icon(Icons.delete),
                label: Text('Delete'))
          ],
        );
        ;
      },
    );
  }

  /*i hate this*/

  Widget quizItemBuilder({DocumentSnapshot doc, BuildContext context}) {
    //so hmm ano gagawin ko kailangan i return dito ung data
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    var type = doc.data['type'];
    if (type == 'header') {
      //header
      //   _quizProvider.countInit();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
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
      );
      //add init counter
    } else {
      //means not header

      var questionType = doc.data['questionType'];

      if (questionType == 'identification') {
        return Identification(
          question: doc.data['question'],
          answer: doc.data['answer'],
        );
      }
      if (questionType == 'multipleChoice') {
        return MultipleChoice(
          question: doc.data['question'],
          choices: doc.data['choices'],
          answer: doc.data['answer'],
        );
      }
      if (questionType == 'trueOrFalse') {
        return TrueOrFalse(
            question: doc.data['question'], answer: doc.data['answer']);
      }
    }

    return Container();
  }
}
