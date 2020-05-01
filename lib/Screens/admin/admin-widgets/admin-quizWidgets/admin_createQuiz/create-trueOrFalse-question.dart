import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminFutures.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTrueOrFalseQuestion extends StatefulWidget {
  @override
  _CreateTrueOrFalseQuestion createState() => _CreateTrueOrFalseQuestion();
}

class _CreateTrueOrFalseQuestion extends State<CreateTrueOrFalseQuestion> {
    int selected;
  bool isRadioSelected = false;
  void changeSelectedRadio({@required int val}) {
    setState(() {
      selected = val;
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var  size = MediaQuery.of(context).size;
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
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                   await AdminService().addTrueOrFalseQuestion(answer: booleanAnswer, question: questionController.text, collectionID: _adminProvider.currentQuiz).then((value) => print('success'));
                  }

//update true or false answer
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
    ),
            )
          ),
        ),
      ),
    );
  }
}
