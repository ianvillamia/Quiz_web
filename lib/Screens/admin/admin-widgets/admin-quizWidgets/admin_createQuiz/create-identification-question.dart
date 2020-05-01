import 'package:Quiz_web/Screens/admin/admin-services/adminFutures.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';

class CreateIdentificationQuestion extends StatefulWidget {
  @override
  _CreateIdentificationQuestion createState() =>
      _CreateIdentificationQuestion();
}

class _CreateIdentificationQuestion
    extends State<CreateIdentificationQuestion> {
  int selected;
  final _formKey = GlobalKey<FormState>();
  String userAnswer;
  TextEditingController answerController = TextEditingController(),
      questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        child: Card(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: TextFormField(
                            controller: questionController,
                            validator: (val) {
                              if (val.length <= 0) {
                                return 'must have values';
                              } else {
                                return null;
                              }
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (val) =>
                        val.isEmpty ? 'please enter value' : null,
                    controller: answerController,
                    decoration: InputDecoration(
                      hintText: 'Input answer',
                      labelText: 'Answer',
                     
                    ),
                  ),
                ),
                MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        String collectionID = _adminProvider.createQuizTitle;
                        await AdminFutures.checkDuplicates(
                                question: questionController.text
                                    .toLowerCase()
                                    .trim(),
                                collection: _adminProvider.createQuizTitle)
                            .then((value) {
                          if (value == true) {
                            print('duplicate values');

                            _adminProvider
                                .changeErrorString('duplicate values');
                          } else {
                            //ok values
                            _adminProvider.changeErrorString(null);
                            AdminService()
                                .addIdentificationQuestion(
                                    answer: answerController.text.trim(),
                                    question: questionController.text,
                                    collectionID: collectionID)
                                .then((value) => _formKey.currentState.reset());
                          }
                        });
                      }

                      //run validator
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
