import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Quiz_web/Models/userState.dart';
import 'package:provider/provider.dart';

class Loader extends StatelessWidget {
  final state;
  Loader({@required this.state});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final loginListener = Provider.of<LoginListener>(context, listen: false);
    switch (loginListener.status) {
      case UserState.Authenticating:
        Future.delayed(Duration(seconds: 1), () {
          loginListener.updateStatus(state: UserState.Authenticated);
        });

        break;
      case UserState.LoggingOut:
        Future.delayed(Duration(seconds: 1), () {
          loginListener.updateStatus(state: UserState.Unauthenticated);
        });

        break;
      default:
    }
    return Scaffold(
      
      backgroundColor: Colors.blue,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: size.width*.3,
        ),
      ),
    );
  }
}
