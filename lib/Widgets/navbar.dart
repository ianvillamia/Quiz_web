import 'package:Quiz_web/Services/Firebase/authenticationService.dart';
import 'package:firebase_web/firebase.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  var router = Router();
  @override
  Widget build(BuildContext context) {
    AuthenticationService auth = AuthenticationService();
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

                  await auth.signOut();
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
                    Navigator.pushNamed(context, '/quiz');
                  },
                  child: Text('Take a Quiz',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  elevation: 0,
                  color: Color.fromRGBO(60, 207, 207, 1),
                  onPressed: () async{
                    await auth.signOut();
                  
                  },
                  child: Text('Review',
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
}
