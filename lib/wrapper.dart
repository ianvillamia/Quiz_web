import 'package:Quiz_web/Models/userState.dart';
import 'package:Quiz_web/Screens/home.dart';
import 'package:Quiz_web/Screens/quiz.dart';
import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:Quiz_web/Widgets/Animations/loader.dart';
import 'package:Quiz_web/Widgets/Animations/logoutLoader.dart';
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
  void initState() {
    // TODO: implement initState
    LoginListener();
  }

  @override
  Widget build(BuildContext context) {
    final loginListener = Provider.of<LoginListener>(context);
    //builds before listening to stream
    switch (loginListener.status) {
      case UserState.Unauthenticated:
        //should show login forms? idduno
        return Home();
      case UserState.Authenticated:
        return Quiz();
        break;

      default:
        break;
    }
    return Loader(state: UserState.Initializing);
  }
}
