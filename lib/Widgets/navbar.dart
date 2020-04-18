import 'package:Quiz_web/Models/userModel.dart';
import 'package:Quiz_web/Services/Firebase/authenticationService.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  var router = Router();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // final user = Provider.of<User>(context);
    if (user == null) {
      print('otherbar');
      return defaultBar();
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
    AuthenticationService auth = AuthenticationService();
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
            await auth.signOut();
          },
          child: Text('Review',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        SizedBox( 
          width: 10,
        )
        ,
        MaterialButton(
       
          color: Color.fromRGBO(60, 207, 207, 1),
        
          child: Text('Log out',style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),),
          onPressed: () async {
            print('let me sign out!');
            // await  popLog(context);

            await auth.signOut().catchError((onError) => print(onError));
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> r) => false);
            //  _resetAndOpenPage(context);
          },
        )
      ],
    );
  }
}
