import 'package:Quiz_web/Models/animationTypes.dart';
import 'package:Quiz_web/Models/userModel.dart';
import 'package:Quiz_web/Services/Firebase/authenticationService.dart';
import 'package:Quiz_web/Widgets/Animations/translate_on_hover.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  AuthenticationService auth = AuthenticationService();
  List<DropdownMenuItem<String>> _dropDownMenuItems;

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

  String _selectedMenuItem;
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
       Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> r) => false);
        signOutFunction(auth);

        break;
        
    }
      setState(() {
          _selectedMenuItem = selected;
        });
  }

  var router = Router();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // final user = Provider.of<User>(context);
    if (user == null) {
   
       return defaultBar();
     // return otherBar();
    } else {
      return otherBar();
    }
  }

  defaultBar() {
    //when user is not logged in
    return Container(
      height: MediaQuery.of(context).size.height * .20,
      width: MediaQuery.of(context).size.width,
      color: Color.fromRGBO(66, 87, 178, 1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  print('tapped');
                  //should go to home
                },
                child: Text(
                  'QuizApp',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                MaterialButton(
                  elevation: 0,
                  color: Color.fromRGBO(60, 207, 207, 1),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  elevation: 0,
                  color: Color.fromRGBO(60, 207, 207, 1),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('Sign up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  otherBar() {
    //when user is logged in
    return Container(
      height: MediaQuery.of(context).size.height * .20,
      width: MediaQuery.of(context).size.width,
      color: Color.fromRGBO(66, 87, 178, 1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  print('tapped');
                  //should go to home
                },
                child: Text(
                  'QuizApp',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
              ),
            ),
            authenticatedButtons()
          ],
        ),
      ),
    );
  }

  authenticatedButtons() {
    return Row(
      children: <Widget>[
        MaterialButton(
          elevation: 0,
          color: Color.fromRGBO(60, 207, 207, 1),
          onPressed: () {
            Navigator.pushNamed(context, '/quiz');
          },
          child: Text('Take a Quiz',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        SizedBox(
          width: 10,
        ),
        MaterialButton(
          elevation: 0,
          color: Color.fromRGBO(60, 207, 207, 1),
          onPressed: () async {
            // await auth.signOut();
          Navigator.pushNamed(context, '/reviewer');
          },
          child: Text('Review',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        SizedBox(
          width: 10,
        ),
        // MaterialButton(
        //   elevation: 0,
        //   color: Color.fromRGBO(60, 207, 207, 1),
        //   child: Text(
        //     'Log out',
        //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   ),
        //   onPressed: () async {
        //     print('let me sign out!');
        //     // await  popLog(context);

        //     await auth.signOut().catchError((onError) => print(onError));
        //     Navigator.of(context)
        //         .pushNamedAndRemoveUntil('/', (Route<dynamic> r) => false);
        //     //  _resetAndOpenPage(context);
        //   },
        // ),
        SizedBox(
          width: 10,
        ),
        TranslateOnHover(
          animationType: AnimationType.moveUp,
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
        )
      ],
    );
  }

  signOutFunction(auth) async {
    print('let me sign out!');

    await auth.signOut().catchError((onError) => print(onError));
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> r) => false);
    //  _resetAndOpenPage(context);
  }
}
