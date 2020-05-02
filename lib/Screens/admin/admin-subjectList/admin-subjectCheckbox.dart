import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-services/adminService.dart';
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
          onChanged: (bool val)async {
            setState(() {
              if (val == false) {
                //pop
                _adminProvider.quizSubjectPop(val: widget.title);
               AdminService().updateQuizzesForSubjectList(title: widget.title);
                //pop quiz from title here
                //step1 get array quizzesID from subjectList
                //step2 remove this.title from array just list.remove()
                //step3 commit array to this.title aka subjects
                
                
              } else {
                //push
               _adminProvider.quizSubjectPush(val: widget.title);
                AdminService().updateQuizzesForSubjectList(title: widget.title);
                //should print out 3d4G30htj
              /*step1 get list
              step2 add the current quiz to list 
              step3 make it unique /distinct
              step4 update database
              step5 
              */
              }
              selected = val;
              //add to list array list then update in firestore create a quizprovider here list
            });
          }),
    );
  }
}
