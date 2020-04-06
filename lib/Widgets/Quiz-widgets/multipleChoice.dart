import 'package:Quiz_web/Widgets/Quiz-widgets/buttonBar.dart';
import 'package:flutter/material.dart';

class MultipleChoice extends StatefulWidget {
  final List choices;
  final String question;
  MultipleChoice({@required this.choices, @required this.question});

  @override
  _MultipleChoiceState createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  int selected;

  @override
  void initState() {
    super.initState();
    selected = 0;
  }

  setSelectedRadio(int value) {
    print('updating');
    setState(() {
      selected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(widget.question),
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: selected,
                    onChanged: (t) {
                      print('selected' + t.toString());
                      setSelectedRadio(t);
                      print(selected);
                    },
                  ),
                  Text(
                    widget.choices[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 2,
                    groupValue: selected,
                    onChanged: (t) {
                      print('selected' + t.toString());
                      setSelectedRadio(t);
                      print(selected);
                    },
                  ),
                  Text(
                    widget.choices[1],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 3,
                    groupValue: selected,
                    onChanged: (t) {
                      print('selected' + t.toString());
                      setSelectedRadio(t);
                      print(selected);
                    },
                  ),
                  Text(
                    widget.choices[2],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 4,
                    groupValue: selected,
                    onChanged: (t) {
                      print('selected' + t.toString());
                      setSelectedRadio(t);
                      print(selected);
                    },
                  ),
                  Text(
                    widget.choices[3],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              QuestionBar()
            ],
          ),
        ),
      ),
    );
  }
}
