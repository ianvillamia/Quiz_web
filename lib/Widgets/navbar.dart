import 'package:flutter/material.dart';
import 'material.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key key}) : super(key: key);

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
            nav_buttons()
          ],
        ),
      ),
    );
  }

  nav_buttons() {
    return Row(
      children: <Widget>[
        CustomMaterialButton(
            function: () {},
            
            color: Color.fromRGBO(60, 207, 207, 1),
            hoverColor: Colors.redAccent,
            text: 'Log in'),
       // IconButton(icon: Icon(Icons.search), onPressed: () {}),
      ],
    );
  }
}
