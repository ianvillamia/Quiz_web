import 'package:Quiz_web/Models/userState.dart';
import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:Quiz_web/Widgets/dialogs.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'Animations/hover_extensions.dart';
import 'package:Quiz_web/Services/routing.dart';
import 'package:provider/provider.dart';
class Navbar extends StatelessWidget {
    final _formKey=GlobalKey<FormState>();
  var router = Router();
  @override
  Widget build(BuildContext context) {
    final loginListener = Provider.of<LoginListener>(context);
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
                onTap: () {
                  Navigator.pushNamed(context, '/home');
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
            nav_buttons(context,loginListener)
          ],
        ),
      ),
    );
  }

  nav_buttons(BuildContext context,loginListener) {
  if(loginListener.status==UserState.Authenticated){
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
          onPressed: () {
            Navigator.pushNamed(context, '/reviewer');
          },
          child: Text('Review',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
  buildButtons(context, loginListener)
     
      ],
    );
  }  
  else{
    return Row(
      
      children: <Widget>[
   
  buildButtons(context, loginListener)
     
      ],
    );
  }
  
  }
  buildButtons(context,loginListener){
    var status =loginListener.status;
    if(status!=UserState.Authenticated){
 return Row(
    
      children: <Widget>[
         MaterialButton(
          elevation: 0,
          color: Color.fromRGBO(60, 207, 207, 1),
          onPressed: () {
            Dialogs().loginDialog(context);
          },
          child: Text('Login',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ).showCursorOnHover,
        SizedBox(
          width: 10,
        ),
          MaterialButton(
          elevation: 0,
          color: Color.fromRGBO(60, 207, 207, 1),
          onPressed: () {
            Dialogs().signUpDialog(context);
          },
          child: Text('SignUp',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ).showCursorOnHover,
      
      ],
    );
    }
    else
    {
      return MaterialButton(onPressed: (){
        //show Logging out 
        loginListener.updateStatus(state:UserState.LoggingOut);
      
        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
      
      },
      color: Colors.amber
      ,child: Text('Sign Out'),);
    }

   
  }
}
