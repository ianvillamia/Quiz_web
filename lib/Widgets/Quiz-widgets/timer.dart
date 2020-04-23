import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Services/Providers/quizProvider.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class Timer extends StatefulWidget {
  const Timer({Key key}) : super(key: key);
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context);

    return Card(
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
                  decoration: BoxDecoration(color: Colors.redAccent),
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
                //  print('state is turned into' + state.toString());
                // print(widget.counter);
                if (_quizProvider.isInit == true) {
                  _quizProvider.changeInit(false);
                  //kailangan never tawagin ang notify listeners when you build
                } else {
                  //   print('state is' + state.toString());
                  _quizProvider.changeTimer(state);
                }
                //     _quizProvider.changeTimer(state);
                //WEIRD TINATAWAG SYA ON INIT BALUGA
                // if (_quizProvider.initCounter != 1) {
                //   print('potato');
                // //  _quizProvider.changeTimer(state);
                // }
                // // _quizProvider.initCounter = 2;
              },
            ),
            MaterialButton(
              onPressed: () {},
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
    );
  }
}
