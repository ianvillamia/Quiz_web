import 'package:Quiz_web/Screens/admin/admin-services/adminFutures.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';

class CreateMultipleChoiceQuestion extends StatefulWidget {
  @override
  _CreateMultipleChoiceQuestion createState() =>
      _CreateMultipleChoiceQuestion();
}

class _CreateMultipleChoiceQuestion
    extends State<CreateMultipleChoiceQuestion> {
  int selected;
  bool isRadioSelected = false;
  void changeSelectedRadio({@required int val}) {
    setState(() {
      selected = val;
    });
  }

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
    final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Container(
        height: size.height * .85,
        width: MediaQuery.of(context).size.width * .8,
        child: Card(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Scrollbar(
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
                Row(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: selected,
                      onChanged: (val) {
                        changeSelectedRadio(val: val);
                        //make this local state
                      },
                    ),
                    Container(
                      width: size.width * .2,
                      child: TextFormField(
                        controller: choice1,
                        validator: (val) {
                          if (val.isEmpty) return 'Should not be empty';
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: selected,
                      onChanged: (val) {
                        changeSelectedRadio(val: val);
                      },
                    ),
                    Container(
                      width: size.width * .2,
                      child: TextFormField(
                        controller: choice2,
                        validator: (val) {
                          if (val.isEmpty) return 'Should not be empty';
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: selected,
                      onChanged: (val) {
                        changeSelectedRadio(val: val);
                      },
                    ),
                    Container(
                      width: size.width * .2,
                      child: TextFormField(
                        validator: (val) {
                          if (val.isEmpty) return 'Should not be empty';
                          return null;
                        },
                        controller: choice3,
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: 4,
                      groupValue: selected,
                      onChanged: (val) {
                        changeSelectedRadio(val: val);
                      },
                    ),
                    Container(
                      width: size.width * .2,
                      child: TextFormField(
                        validator: (val) {
                          if (val.isEmpty) return 'Should not be empty';
                          return null;
                        },
                        controller: choice4,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'please select the value of the correct answer',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton.icon(
                      color: Colors.blueAccent,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (selected == null) {
                            setState(() {
                              isRadioSelected = true;
                            });
                          } else {
                            List editedChoices = [
                              choice1.text.toLowerCase().trim(),
                              choice2.text.toLowerCase().trim(),
                              choice3.text.toLowerCase().trim(),
                              choice4.text.toLowerCase().trim()
                            ];
                            String answer;
                            //show error if has no selected
                            switch (selected) {
                              case 1:
                                answer = choice1.text;

                                break;
                              case 2:
                                answer = choice2.text;
                                break;
                              case 3:
                                answer = choice3.text;
                                break;
                              case 4:
                                answer = choice4.text;
                                break;
                              default:
                            }
                            await AdminService()
                                .addMultipleQuestion(
                                    answer: answer,
                                    question: questionController.text,
                                    choices: editedChoices,
                                    collectionID: _adminProvider.currentQuiz)
                                .then((value) => print('success'+_adminProvider.currentQuiz.toString()));

                            //run async

                          } //update true or false answer
                        }
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: Text(
                        'ADD Question',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Center(
                    child: Visibility(
                        visible: isRadioSelected,
                        child: Container(
                            width: size.width,
                            height: size.height * .05,
                            color: Colors.redAccent,
                            child: Center(
                              child: Text(
                                'Please choose an answer',
                                style: TextStyle(color: Colors.white),
                              ),
                            ))))
              ],
            ),
          )),
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
