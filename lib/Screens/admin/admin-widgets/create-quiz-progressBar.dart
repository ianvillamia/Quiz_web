import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateQuizProgressBar extends StatefulWidget {
  @override
  _CreateQuizProgressBarState createState() => _CreateQuizProgressBarState();
}

class _CreateQuizProgressBarState extends State<CreateQuizProgressBar> {
  int step;
  @override
  void initState() { 
    super.initState();
        final _adminProvider= Provider.of<AdminProvider>(context,listen: false);
        step=_adminProvider.createQuizStep;
  }

  @override
  Widget build(BuildContext context) {
    final _adminProvider= Provider.of<AdminProvider>(context);
    var size = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),

      height: size.height * .15,
      //le parent
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text('Step'),
          ),

          //
          Center(
              child: Container(
            height: 5,
            width: size.width,
            color: Colors.black,
          )),
          //le buttons
          Center(
              child: Container(width: size.width, child: buttonHolder(
                selected: step
              )
                  //here change container

                  )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Create Quiz Headers',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'Add Questions',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buttonHolder({int selected}) {
    if (selected == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          numberBuilder(
              number: "1", isSelected: true, toolTip: 'Create header'),
          numberBuilder(
              number: "2", isSelected: false, toolTip: 'add question'),
      
        ],
      );
    }
    if (selected == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          numberBuilder(
              number: "1", isSelected: false, toolTip: 'Create header'),
          numberBuilder(number: "2", isSelected: true, toolTip: 'add question'),
        
        ],
      );
    }
  
  }

  numberBuilder({String number, bool isSelected, String toolTip}) {
    return Tooltip(
      message: toolTip,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            shape: BoxShape.circle,
            color: isSelected ? Color.fromRGBO(254, 175, 98, 1) : Colors.white),
        width: 50,
        height: 50,
        child: Center(
          child: Text(number),
        ),
      ),
    );
  }
}
