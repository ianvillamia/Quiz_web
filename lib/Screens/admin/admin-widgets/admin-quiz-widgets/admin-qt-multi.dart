import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminMultipleChoice extends StatefulWidget {
  final List choices;
  final String question;
  final String answer;
  final bool isIgnoring;
  AdminMultipleChoice(
      {@required this.choices,
      @required this.question,
      @required this.answer,
      @required this.isIgnoring});

  @override
  _AdminMultipleChoice createState() => _AdminMultipleChoice();
}

class _AdminMultipleChoice extends State<AdminMultipleChoice> {
  int selected;
  String userAnswer;
  TextEditingController choice1 = TextEditingController(),
      choice2 = TextEditingController(),
      choice3 = TextEditingController(),
      choice4 = TextEditingController(),
      answerController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    changeSelectedValue(int val) {
      setState(() {
        selected = val;
        getUserAnswer(value: selected);
        _quizProvider.onChangeMultipleChoice(
            correctAnswer: widget.answer, userAnswer: userAnswer);
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                  title: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: TextFormField(
                        // controller: questionController,
                        onChanged: (val) {
                          setState(() {});
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
                ),
              )),
              buildChoiceItem(
                  controller: choice1, hintText: 'Enter value for choice1'),
              buildChoiceItem(
                  controller: choice2, hintText: 'Enter value for choice2'),
              buildChoiceItem(
                  controller: choice3, hintText: 'Enter value for choice3'),
              buildChoiceItem(
                  controller: choice4, hintText: 'Enter value for choice4'),
       
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator:,
                    controller: answerController,
                    decoration: InputDecoration(
                      hintText: 'Input answer',
                      labelText: 'Answer',
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              MaterialButton(
                  onPressed: () {
                    //run validator
                  },
                  color: Colors.blue,
                  child: Text(
                    'Add Question',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
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
              child: TextField(
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

  getUserAnswer({int value}) {
    switch (value) {
      case 1:
        userAnswer = widget.choices[0];
        break;
      case 2:
        userAnswer = widget.choices[1];
        break;
      case 3:
        userAnswer = widget.choices[2];
        break;
      case 4:
        userAnswer = widget.choices[3];
        break;
    }
  }
}
