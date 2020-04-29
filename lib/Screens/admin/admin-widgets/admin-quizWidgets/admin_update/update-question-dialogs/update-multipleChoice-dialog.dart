import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateMultipleChoiceDialog extends StatefulWidget {
  final DocumentSnapshot doc;
  UpdateMultipleChoiceDialog({@required this.doc});

  @override
  _UpdateMultipleChoiceDialogState createState() =>
      _UpdateMultipleChoiceDialogState();
}

class _UpdateMultipleChoiceDialogState
    extends State<UpdateMultipleChoiceDialog> {
  int selected;
  bool isRadioSelected = false;
  void changeSelectedRadio({@required int val}) {
    setState(() {
      selected = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var doc = widget.doc;
    TextEditingController choice1 = TextEditingController(),
        choice2 = TextEditingController(),
        choice3 = TextEditingController(),
        choice4 = TextEditingController();

    List choices = doc.data['choices'];
    choice1.text = StringUtils.capitalize(choices[0].toString());
    choice2.text = StringUtils.capitalize(choices[1].toString());
    choice3.text = StringUtils.capitalize(choices[2].toString());
    choice4.text = StringUtils.capitalize(choices[3].toString());

    var size = MediaQuery.of(context).size;

    TextEditingController questionController = TextEditingController();

    questionController.text = doc.data['question'].toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: questionController,
          decoration: InputDecoration(labelText: 'Question'),
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
                      .updateMultipleChoiceQuestion(
                          question: questionController.text,
                          answer: answer.toLowerCase().trim(),
                          choices: editedChoices, //edited choices
                          doc: doc,
                          context: context)
                      .then((value) {
                    Navigator.pop(context);
                  });

                  //run async

                } //update true or false answer
              },
              icon: Icon(
                Icons.update,
                color: Colors.white,
              ),
              label: Text(
                'Update',
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
    );
  }
}
