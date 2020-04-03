import 'package:Quiz_web/Themes/colors.dart';
import 'package:Quiz_web/Widgets/material.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[Navbar(), section1(context)],
        ),
      ),
    );
  }

  section1(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 55, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Padding(
                    padding: EdgeInsets.all(80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Become your most unstoppable self',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.black),
                        ),
                        Text(
                          'Challenge Study and Learn',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          elevation: 5,
                          color: Color.fromRGBO(60, 207, 207, 1),
                          height: 80,
                          child: Text(
                            'Lets Get Started',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Image.asset('assets/study.jpg'),
              ),
            ],
          )),
    );
  }
}
