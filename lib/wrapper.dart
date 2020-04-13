import 'package:Quiz_web/Models/userState.dart';
import 'package:Quiz_web/Screens/home.dart';
import 'package:Quiz_web/Screens/quiz.dart';
import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:Quiz_web/Widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Models/userState.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final loginListener = Provider.of<LoginListener>(context);
     
    switch (loginListener.status) {
      case UserState.Unauthenticated:
      //should show login forms? idduno
      
        return Home();
      case UserState.Authenticated:
      //should show home? idunno 
        return Quiz();
      case UserState.Authenticating:
        return Loading(
         
        );

        break;
      default:
        Container();
    }
     return Container();
  }
}
