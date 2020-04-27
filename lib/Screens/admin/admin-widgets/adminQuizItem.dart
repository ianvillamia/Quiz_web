import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quiz-widgets/admin-qt-identification.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quiz-widgets/admin-qt-multi.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-quiz-widgets/admin-qt-trueOrFalse.dart';
import 'package:flutter/material.dart';

class AdminQuizItem extends StatefulWidget {
  AdminQuizItem({Key key}) : super(key: key);

  @override
  _AminQuizItemState createState() => _AminQuizItemState();
}

class _AminQuizItemState extends State<AdminQuizItem> {
  TextEditingController questionController = TextEditingController();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _questionType;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = List();
    void addItem({String value, String text}) {
      items.add(DropdownMenuItem(
        value: value,
        child: Text(
          text,
        ),
      ));
    }

    addItem(text: 'Multiple Choice', value: 'q-type-mult');
    addItem(text: 'Identification', value: 'q-type-iden');
    addItem(text: 'True or False', value: 'q-type-tf');
    return items;
  }

  @override
  void initState() {
    questionController.text = 'sample question';
    // TODO: implement initState
    super.initState();
    _dropDownMenuItems = getDropDownMenuItems();
    _questionType = _dropDownMenuItems[0].value;
  }

  void changeDropDownItem(String selected) {
    setState(() {
      questionController.text = 'enter question';
      _questionType = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    //parent size widget   height: size.height * .6,  width: size.width * .3,
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: size.height,
        width: size.width * .3,
        color: Color.fromRGBO(229, 229, 229, 1),
        child: Column(
          children: <Widget>[
            /************************************section1*************************************/

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: size.height * .1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        value: _questionType,
                        items: _dropDownMenuItems,
                        onChanged: changeDropDownItem,
                      ),
                    ),
                  ),
                ),
                //Multiline question textfield
                Container(
                    child: SingleChildScrollView(child: questionWidget()))
              ],
            ),

/************************************section2*************************************/
          ],
        ),
      ),
    );
  }

  Widget questionWidget() {
    if (_questionType == 'q-type-mult') {
      return AdminMultipleChoice(
        choices: [
          'a',
          'a',
          'a',
          'a',
        ],
        question: questionController.text,
        answer: 'nada',
        isIgnoring: true,
      );
    }
    if (_questionType == 'q-type-iden') {
      return AdminIdentification(
          question: questionController.text, answer: 'cool');
    }
    if (_questionType == 'q-type-tf') {
      return AdminTrueOrFalse(question: questionController.text, answer: true);
    }
  }
}
