import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:Quiz_web/Services/routing.dart';

class Navbar extends StatelessWidget {
  var router = Router();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .20,
      width: MediaQuery.of(context).size.width,
      color: Color.fromRGBO(66, 87, 178, 1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: (){
                  Navigator.pushNamed(context, '/');
              },
                          child: Text(
                'QuizApp',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
            ),
            nav_buttons(context)
          ],
        ),
      ),
    );
  }

  nav_buttons(BuildContext context) {
    return Row(
      children: <Widget>[
   
        SizedBox(
          width: 10,
        ),
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

        // IconButton(icon: Icon(Icons.search), onPressed: () {}),
      ],
    );
  }
}
