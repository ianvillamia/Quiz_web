import 'package:Quiz_web/Services/Firebase/authenticationService.dart';
import 'package:flutter/material.dart';
class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       AuthenticationService _auth = AuthenticationService();
    return Scaffold(
        body: Center(
      child: MaterialButton(
        onPressed: () async {
          dynamic result = await _auth.signInAnon();

          if(result==null){
            print('error signing in');
          }
          else{
            print('print signed in');
            print(result.uid);
          }
        },
        child: Text('Sign in Anonymously'),
      ),
    ));
  }
}