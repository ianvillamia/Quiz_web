import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateTrueOrFalseDialog extends StatefulWidget {
  final DocumentSnapshot doc;
  UpdateTrueOrFalseDialog({@required this.doc});
  @override
  _UpdateTrueOrFalseDialogState createState() =>
      _UpdateTrueOrFalseDialogState();
}

class _UpdateTrueOrFalseDialogState extends State<UpdateTrueOrFalseDialog> {
  int selected;
  bool isRadioSelected = false;
  void changeSelectedRadio({@required int val}) {
    setState(() {
      selected = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var doc = widget.doc;
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
              },
            ),
            Text('True')
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
            Text('False')
          ],
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
                  var booleanAnswer = false;
                  if (selected == 1) {
                    booleanAnswer = true;
                  }
                  await AdminService()
                      .updateTrueOrFalseQuestion(
                          context: context,
                          question: questionController.text,
                          answer: booleanAnswer,
                          doc: doc)
                      .then((value) {
                    print('success');
                    Navigator.pop(context);
                  });
                }

//update true or false answer
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(
                'Add Question',
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
