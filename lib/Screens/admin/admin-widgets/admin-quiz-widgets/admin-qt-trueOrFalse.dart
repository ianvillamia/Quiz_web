import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminFutures.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/buttonBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminTrueOrFalse extends StatefulWidget {
  @override
  _AdminTrueOrFalse createState() => _AdminTrueOrFalse();
}

class _AdminTrueOrFalse extends State<AdminTrueOrFalse> {
  int selected;
  final _formKey = GlobalKey<FormState>();
  TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
    changeSelectedValue(int val) {
      setState(() {
        selected = val;
      });
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                    title: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: TextFormField(
                          controller: questionController,
                          validator: (val) {
                            if (val.length <= 0) {
                              _adminProvider
                                  .changeErrorString('must not be empty');
                            }
                            return _adminProvider.errorText;
                          },
                          onChanged: (val) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            labelText: 'Question',
                            hintText: 'type question here',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          minLines: 3,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),
                )),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: selected,
                      onChanged: (val) {
                        changeSelectedValue(val);
                      },
                    ),
                    Text(
                      "True",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: selected,
                      onChanged: (val) {
                        changeSelectedValue(val);
                      },
                    ),
                    Text(
                      "False",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                //material button here
                MaterialButton(
                    onPressed: () async {
                      //run validator
                      if (_formKey.currentState.validate()) {}
                      String collectionID = _adminProvider.createQuizTitle;
                      await AdminFutures.checkDuplicates(
                              question:
                                  questionController.text.toLowerCase().trim(),
                              collection: _adminProvider.createQuizTitle)
                          .then((value) {
                        if (value == true) {
                          print('duplicate values');

                          _adminProvider.changeErrorString('duplicate values');
                        } else {
                          _adminProvider.changeErrorString(null);
                          //run here no duplicates
                          bool answerVal = false;
                          if (selected == 1) {
                            answerVal = true;
                          }

                          AdminService()
                              .addTrueOrFalseQuestion(
                                  answer: answerVal,
                                  question: questionController.text,
                                  collectionID: collectionID)
                              .then((value) => _formKey.currentState.reset());
                        }
                      });
                    },
                    color: Colors.blue,
                    child: Text(
                      'Add Question',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
