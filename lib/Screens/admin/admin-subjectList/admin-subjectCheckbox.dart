import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectCheckBox extends StatefulWidget {
  final String title;
  final bool isSelected;
  final DocumentSnapshot doc;
  SubjectCheckBox(
      {@required this.title, @required this.isSelected, @required this.doc});
  @override
  _SubjectCheckBoxState createState() => _SubjectCheckBoxState();
}

class _SubjectCheckBoxState extends State<SubjectCheckBox> {
  // bool isSelected;
  bool selected;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    final _adminProvider = Provider.of<AdminProvider>(context, listen: false);
    return ListTile(
      title: Text(StringUtils.capitalize(widget.title)),
      trailing: Checkbox(
          value: selected,
          onChanged: (bool val) {
            setState(() {
              if (val == false) {
                //pop
                _adminProvider.quizSubjectPop(val: widget.title);
              } else {
                //push
               _adminProvider.quizSubjectPush(val: widget.title);
              }
              selected = val;
              //add to list array list then update in firestore create a quizprovider here list
            });
          }),
    );
  }
}
