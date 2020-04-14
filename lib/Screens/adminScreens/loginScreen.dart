
import 'package:flutter/material.dart';
import 'package:Quiz_web/Extensions/hover_extensions.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            child: Container(
              width: size.width * .6,
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/java.jpg"), fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              height: size.height,
              width: size.width * .4,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * .1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[header(size), formContainer(size,context)],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  header(size) {
    return Container(
      width: size.width,
      height: size.height * .2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Opacity(
          opacity: .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }

  formContainer(size,context) {
    return Padding(
      padding: EdgeInsets.all(size.height * .05),
      child: Container(
        height: size.height * .5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(
                  fontSize: size.height * .05, fontWeight: FontWeight.w600),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'example@gmail.com',
                labelText: 'Username',
              ),
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: '*********',
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                color: Color.fromRGBO(75, 85, 95, 1),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )).showCursorOnHover
          ],
        ),
      ),
    );
  }
}
