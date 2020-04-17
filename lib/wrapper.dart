import 'package:Quiz_web/Models/userModel.dart';
import 'package:Quiz_web/Services/Firebase/authenticationService.dart';

import 'package:Quiz_web/Screens/adminScreens/loginScreen.dart';
import 'package:Quiz_web/Widgets/pageBuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  var currentPage = '/home';
  AuthenticationService auth = AuthenticationService();
  @override
  Widget build(BuildContext context) {
 
    final user = Provider.of<User>(context);
    if (user == null) {
      //not signed in

      return LoginScreen();
    } else {
      //return pagebuilder

      return PageBuilder(page: currentPage);
    }
  }

 
}
