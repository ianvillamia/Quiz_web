import 'package:Quiz_web/Widgets/Animations/loader.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/identification.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/multipleChoice.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:Quiz_web/Widgets/Quiz-widgets/trueOrFalse.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';

class QuizBuilder extends StatefulWidget {
  const QuizBuilder({Key key}) : super(key: key);
  @override
  _QuizBuilderState createState() => _QuizBuilderState();
}

class _QuizBuilderState extends State<QuizBuilder> {
  final db = Firestore.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context);

    return loading
        ? Loading()
        : Scaffold(
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height * .2,
                  child: Container(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height * .8,
                    width: MediaQuery.of(context).size.width * .7,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db
                          .collection('quiz1') //_quizProvider.currentQuiz
                          .orderBy('order')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return Scrollbar(
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: snapshot.data.documents
                                      .map((doc) => quizItemBuilder(
                                          doc: doc, context: context))
                                      .toList()),
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Navbar(),
                ),
                //create a submit button
                Positioned(
                    top: MediaQuery.of(context).size.height * .5,
                    right: 0,
                    child: Card(
                      child: Container(
                        width: 250,
                        height: 200,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 75,
                              child: Visibility(
                                visible: _quizProvider.isTimerVisible,
                                child: SlideCountdownClock(
                                  duration: Duration(minutes: 1),
                                  slideDirection: SlideDirection.Up,
                                  separator: "-",
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  separatorTextStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  decoration:
                                      BoxDecoration(color: Colors.redAccent),
                                  onDone: () {},
                                ),
                              ),
                            ),
                            LiteRollingSwitch(
                              //initial value
                              value: _quizProvider.isTimerVisible,
                              textOn: 'Timer on',
                              textOff: 'Timer off',
                              colorOn: Colors.greenAccent[700],
                              colorOff: Colors.redAccent[700],
                              iconOn: Icons.alarm_on,
                              animationDuration: Duration(milliseconds: 500),
                              iconOff: Icons.alarm_off,
                              textSize: 10.0,
                              onChanged: (bool state) {
                          
                                if (_quizProvider.isInit == true) {
                                  _quizProvider.changeInit(false);
                                  //kailangan never tawagin ang notify listeners when you build
                                } else {
                                  //   print('state is' + state.toString());
                                  _quizProvider.changeTimer(state);
                                }
                              
                              },
                            ),
                            MaterialButton(
                              onPressed: () {
                                print('loading...');

                                setState(() => loading = true);
                                submitScore();
                                print(loading);
                              },
                              color: Colors.blue,
                              elevation: 0,
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          );
  }

  Widget quizItemBuilder({DocumentSnapshot doc, BuildContext context}) {
    //so hmm ano gagawin ko kailangan i return dito ung data
    final _quizProvider = Provider.of<QuizProvider>(context, listen: false);
    var type = doc.data['type'];
    if (type == 'header') {
      //header
      //   _quizProvider.countInit();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                    title: Text(
                  doc.data['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(doc.data['instructions'].toString())),
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Time allotted:'),
                            Text('15 mins')
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Created By:'),
                        Text(
                          doc.data['creator'].toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
      //add init counter
    } else {
      //means not header

      var questionType = doc.data['questionType'];

      if (questionType == 'identification') {
        return Identification(
          question: doc.data['question'],
          answer: doc.data['answer'],
        );
      }
      if (questionType == 'multipleChoice') {
        return MultipleChoice(
          question: doc.data['question'],
          choices: doc.data['choices'],
          answer: doc.data['answer'],
        
        );
      }
      if (questionType == 'trueOrFalse') {
        return TrueOrFalse(
            question: doc.data['question'], answer: doc.data['answer']);
      }
    }

    return Container();
  }

  void submitScore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() => loading = false);
      //navigator push
    }).then((value) =>  Navigator.pushNamed(context, '/quizScore'));
  }
}
