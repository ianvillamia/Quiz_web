import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateHeaderDialog extends StatefulWidget {
  final DocumentSnapshot doc;
  UpdateHeaderDialog({@required this.doc});
  @override
  _UpdateHeaderDialog createState() => _UpdateHeaderDialog();
}

class _UpdateHeaderDialog extends State<UpdateHeaderDialog> {
  @override
  Widget build(BuildContext context) {
    var doc = widget.doc;
    TextEditingController creatorNameController = TextEditingController(),
        instructionController = TextEditingController(),
        titleController = TextEditingController(),
        hourController = TextEditingController(),
        minuteController = TextEditingController();

    creatorNameController.text =
        StringUtils.capitalize(doc.data['creator'].toString());
    titleController.text = StringUtils.capitalize(doc.data['title'].toString());
    hourController.text = StringUtils.capitalize(doc.data['hour'].toString());
    minuteController.text =
        StringUtils.capitalize(doc.data['minute'].toString());
    instructionController.text =
        StringUtils.capitalize(doc.data['instructions'].toString());
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return 'Please input a value';
              } else
                return null;
            },
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: instructionController,
            validator: (val) {
              if (val.isEmpty) {
                return 'Please input a value';
              } else
                return null;
            },
            decoration: InputDecoration(labelText: 'Instructions'),
          ),
          TextFormField(
            controller: creatorNameController,
            validator: (val) {
              if (val.isEmpty) {
                return 'Please input a value';
              } else
                return null;
            },
            decoration: InputDecoration(labelText: 'Creator Name'),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 80,
                child: TextFormField(
                    controller: hourController,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration:
                        InputDecoration(labelText: "Hours", hintText: '00'),
                    validator: (val) {
                      // print('validating');
                      if (val.length <= 0) {
                        return 'must not be empty';
                      } else {
                        return null;
                      }
                    }),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 80,
                child: TextFormField(
                    controller: minuteController,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: "Minutes", hintText: '00'),
                    validator: (val) {
                      if (int.parse(val) > 60) {
                        return 'Invalid input';
                      }
                      // print('validating');
                      if (val.length <= 0) {
                        return 'must not be empty';
                      } else {
                        return null;
                      }
                    }),
              ),
            ],
          ),
          FlatButton.icon(
              color: Colors.blueAccent,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  await AdminService()
                      .updateQuizHeader(
                          context: context,
                          creatorName: creatorNameController.text,
                          instructions: instructionController.text,
                          // time: timeController.text,
                          hour: int.parse(hourController.text),
                          minute: int.parse(minuteController.text),
                          title: titleController.text,
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
