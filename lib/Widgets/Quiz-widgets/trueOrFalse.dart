import 'package:Quiz_web/Widgets/Quiz-widgets/buttonBar.dart';
import 'package:flutter/material.dart';

class TrueOrFalse extends StatefulWidget {
  final String question;

  TrueOrFalse({this.question});
  @override
  _TrueOrFalseState createState() => _TrueOrFalseState();
}

class _TrueOrFalseState extends State<TrueOrFalse> {
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
               ListTile(title: Text(widget.question)),
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
                    "True",
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
                    "False",
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
