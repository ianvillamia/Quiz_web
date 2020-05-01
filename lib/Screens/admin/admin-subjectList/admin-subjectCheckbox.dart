import 'package:flutter/material.dart';
class SubjectCheckBox extends StatefulWidget {
  final String title;
SubjectCheckBox({@required this.title});
  @override
  _SubjectCheckBoxState createState() => _SubjectCheckBoxState();
}

class _SubjectCheckBoxState extends State<SubjectCheckBox> {
   bool selected = false;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(widget.title),
      trailing: Checkbox(
          value: selected,
          onChanged: (bool val) {
            print(val);
            setState(() {
              selected = val;
              //add to list array list then update in firestore create a quizprovider here list 
            });
          }),
    );
  }
}