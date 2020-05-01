import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateIdentificationDialog extends StatefulWidget {
  final DocumentSnapshot doc;
  UpdateIdentificationDialog({@required this.doc});
  @override
  _UpdateIdentificationDialogState createState() =>
      _UpdateIdentificationDialogState();
}

class _UpdateIdentificationDialogState
    extends State<UpdateIdentificationDialog> {
  @override
  Widget build(BuildContext context) {
    var doc = widget.doc;
    TextEditingController questionController = TextEditingController(),
        answerController = TextEditingController();
        questionController.text=StringUtils.capitalize(doc.data['question'].toString());
        answerController.text=StringUtils.capitalize(doc.data['answer'].toString());
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
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
          TextFormField(
            controller: answerController,
            validator: (val) {
              if (val.isEmpty) {
                return 'Please input a value';
              } else
                return null;
            },
            decoration: InputDecoration(labelText: 'Answer'),
          ),
          FlatButton.icon(
              color: Colors.redAccent,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  await AdminService()
                      .updateIdentificationQuestion(
                          context: context,
                          question: questionController.text,
                          answer: answerController.text.toLowerCase().trim(),
                          doc: doc)
                      .then((value) {
                    print('success');
                    Navigator.pop(context);
                  });
                }
                //update identification pass document id answer question
              },
              icon: Icon(
                Icons.update,
                color: Colors.white,
              ),
              label: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
