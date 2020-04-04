import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'material.dart';

import 'package:Quiz_web/Services/routing.dart';

class Navbar extends StatelessWidget {
  var router = Router();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .20,
      color: Color.fromRGBO(66, 87, 178, 1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'QuizApp',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
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
        MaterialButton(
          color:Colors.green,
          elevation:0,
          onPressed: () {        
          Navigator.pushNamed(context, '/');
          },
          child: Text('Home',style:TextStyle(fontSize:15)),
        ),
        SizedBox(
          width: 10,
        ),
          MaterialButton(
            color:Color.fromRGBO(60, 207, 207, 1),
            
          onPressed: () {
           
          Navigator.pushNamed(context, '/quiz');
          },
          child: Text('Quiz'),
        ),

        // IconButton(icon: Icon(Icons.search), onPressed: () {}),
      ],
    );
  }
}
