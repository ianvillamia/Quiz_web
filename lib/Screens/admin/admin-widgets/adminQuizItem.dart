import 'package:flutter/material.dart';

class AdminQuizItem extends StatefulWidget {
  AdminQuizItem({Key key}) : super(key: key);

  @override
  _AminQuizItemState createState() => _AminQuizItemState();
}

class _AminQuizItemState extends State<AdminQuizItem> {
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedMenuItem;
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = List();
    items.add(DropdownMenuItem(
      value: 'username',
      child: Text(
        'ianvillamia@gmail.com',
        style: TextStyle(color: Colors.white),
      ),
    ));
    items.add(DropdownMenuItem(
      value: 'Profile',
      child: Text(
        'Profile',
        style: TextStyle(color: Colors.white),
      ),
    ));
    items.add(DropdownMenuItem(
      value: 'Quizzes',
      child: Text('Quizzes', style: TextStyle(color: Colors.white)),
    ));
    items.add(DropdownMenuItem(
      value: 'Log-out',
      child: Text('Log-out', style: TextStyle(color: Colors.white)),
    ));
    return items;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _dropDownMenuItems = getDropDownMenuItems();
    _selectedMenuItem = _dropDownMenuItems[0].value;
  }

  void changeDropDownItem(String selected) {
    switch (selected.toLowerCase()) {
      case 'profile':
        //route to profile

        break;
      case 'Quizzes':
        //route to quizes

        break;
      case 'log-out':
        //  Navigator.of(context)
        //           .pushNamedAndRemoveUntil('/', (Route<dynamic> r) => false);
        //   signOutFunction(auth);

        break;
    }
    setState(() {
      _selectedMenuItem = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    //parent size widget   height: size.height * .6,  width: size.width * .3,
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: size.height * .6,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            /*section1*/
            Container(
              height: size.height * .2,
              width: size.width * .3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(

                    color: Colors.grey,
                    height: size.height * .1,
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      focusColor: Colors.white,
                      dropdownColor: Color.fromRGBO(66, 87, 178, 1),
                      value: _selectedMenuItem,
                      items: _dropDownMenuItems,
                      onChanged: changeDropDownItem,

                      //call a function that hanldes these changes
                      //logout and routing
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Question',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /*section2*/
            Container(
              height: size.height * .2,
              width: size.width * .3,
              color: Colors.redAccent,
            ),
            /*section3*/
            Container(
              height: size.height * .2,
              width: size.width * .3,
              color: Colors.yellowAccent,
            )
          ],
        ),
      ),
    );
  }
}
