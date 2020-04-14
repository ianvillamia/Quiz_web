import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Quiz_web/Models/userState.dart';
import 'package:provider/provider.dart';


class LogOutLoader extends StatelessWidget {

 
  doSomething(loginListener,context){
    Future.delayed(Duration(seconds: 1),(){
    loginListener.updateStatus(state: UserState.Unauthenticated);
 
    });

  }
  @override
  Widget build(BuildContext context) {
         final loginListener = Provider.of<LoginListener>(context,listen: false);
      doSomething(loginListener,context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: SpinKitCubeGrid(
            color: Colors.white,
            size: 50,
          ),
      ),
    );
  }
}