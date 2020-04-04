import 'package:flutter/material.dart';

class QuizItems {
  trueOrFalse(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        child: Card(
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                    'In a three-phase system, the voltages are separated by:'),
              ),
              choiceTile(value: 1, text: "True"),
              choiceTile(value: 2, text: "False"),
              buttonBar()
            ],
          ),
        ),
      ),
    );
  }

  choiceTile({int value, String text, int selected}) {
    return Row(
      children: <Widget>[
        Radio(
          value: value,
          groupValue: selected,
          onChanged: (t) {
            //do update provider
          },
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  multipleChoice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        child: Card(
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                    'In a three-phase system, the voltages are separated by:'),
              ),
              choiceTile(value: 1, text: "45"),
              choiceTile(value: 2, text: "95"),
              choiceTile(value: 3, text: "145"),
              choiceTile(value: 4, text: "19"),
              buttonBar()
            ],
          ),
        ),
      ),
    );
  }

  identification(BuildContext context, {String question}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text(question),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: 350,
                  child: TextField(
                    controller: null,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                    ),
                  ),
                ),
              ),
              buttonBar()
            ],
          ),
        ),
      ),
    );
  }

  fillInTheBlank() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
            child: Card(
                child: Column(
                            children: <Widget>[
                              Row(
          children: <Widget>[
            Text('Some Question with'), 
            SizedBox(width: 10,),
            Container(
              width: 150,
              child: TextField(
                  controller: null,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),
                  ),
              ),
            ),
            Text('Continuation of that Question'),
          ],
        ),
        buttonBar()
                            ],
                ))));
  }

  buttonBar() {
    return ButtonBar(
      children: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.lightbulb_outline),
          label: Text('View Answer'),
          onPressed: () {/* ... */},
        ),
        FlatButton(
          child: const Text('Report'),
          onPressed: () {/* ... */},
        ),
      ],
    );
  }
}
