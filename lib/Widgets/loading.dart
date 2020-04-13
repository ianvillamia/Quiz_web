import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Quiz_web/Models/userState.dart';
import 'package:provider/provider.dart';


class Loading extends StatelessWidget {
  final String routeName;
  Loading({@required this.routeName});
 
  doSomething(loginListener,context){
    Future.delayed(Duration(seconds: 3),(){
    loginListener.updateStatus(state: UserState.Authenticated);
    Navigator.pushNamed(context, routeName);
    });

  }
  @override
  Widget build(BuildContext context) {
         final loginListener = Provider.of<LoginListener>(context,listen: false);
      doSomething(loginListener,context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: SpinKitChasingDots(
            color: Colors.white,
            size: 50,
          ),
      ),
    );
  }
}