import 'package:Quiz_web/Models/userModel.dart';
import 'package:Quiz_web/Services/Firebase/authenticationService.dart';

import 'package:Quiz_web/Screens/authScreens/loginScreen.dart';
import 'package:Quiz_web/Widgets/pageBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var currentPage = '/home';
  final loading = false;
  AuthenticationService auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: AuthenticationService().user,
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData){
return PageBuilder(page: currentPage);
        }
        else{
         return LoginScreen();
        }
      },
    );
    // final user = Provider.of<User>(context);
    // print(user);
    // if (user == null) {
    //   //not signed in

    //   return LoginScreen();
    // } else {
    //   //return pagebuilder
    //   return PageBuilder(page: currentPage);
    // }
  }
}
