import 'package:Quiz_web/Screens/admin/admin-services/adminFutures.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';

class AdminMultipleChoice extends StatefulWidget {
  @override
  _AdminMultipleChoice createState() => _AdminMultipleChoice();
}

class _AdminMultipleChoice extends State<AdminMultipleChoice> {
  int selected;
  final _formKey = GlobalKey<FormState>();
  String userAnswer;
  TextEditingController choice1 = TextEditingController(),
      choice2 = TextEditingController(),
      choice3 = TextEditingController(),
      choice4 = TextEditingController(),
      answerController = TextEditingController(),
      questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _adminProvider = Provider.of<AdminProvider>(context);
    return Form(
      key: _formKey,
      child: Container(
        height: size.height * .85,
        width: MediaQuery.of(context).size.width * .8,
        child: Card(
          child: SingleChildScrollView(
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
                buildChoiceItem(
                    controller: choice1, hintText: 'Enter value for choice1'),
                buildChoiceItem(
                    controller: choice2, hintText: 'Enter value for choice2'),
                buildChoiceItem(
                    controller: choice3, hintText: 'Enter value for choice3'),
                buildChoiceItem(
                    controller: choice4, hintText: 'Enter value for choice4'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'please enter value' : null,
                      controller: answerController,
                      decoration: InputDecoration(
                        hintText: 'Input answer',
                        labelText: 'Answer',
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                    onPressed: () async {
                      List choiceList = [
                        choice1.text.trim(),
                        choice2.text.trim(),
                        choice3.text.trim(),
                        choice4.text.trim()
                      ];
                   

                      //run validator
                      //check choices are the same...

                      if (_formKey.currentState.validate()) {}
                      await AdminFutures.checkDuplicates(
                              question:
                                  questionController.text.toLowerCase().trim(),
                              collection: _adminProvider.createQuizTitle)
                          .then((value) {
                        if (value == true) {
                          print('duplicate values');

                          _adminProvider.changeErrorString('duplicate values');
                        } else {
                          //values ok
                          _adminProvider.changeErrorString(null);
                          String collectionID = _adminProvider.createQuizTitle;
                          AdminService()
                              .addMultipleQuestion(
                                  answer: answerController.text.trim(),
                                  question: questionController.text,
                                  choices: choiceList,
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

  buildChoiceItem(
      {@required TextEditingController controller, @required String hintText}) {
    return ListTile(
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 30,
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 3,
                        color: Color.fromRGBO(61, 61, 61, .7),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            Container(
              width: 200,
              child: TextFormField(
                validator: (val) => val.isEmpty ? 'Please enter a value' : null,
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
