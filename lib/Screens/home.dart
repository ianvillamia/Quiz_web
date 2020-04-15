import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:Quiz_web/Themes/colors.dart';

import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Models/userState.dart';


class Home extends StatefulWidget {
  
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
@override
void initState() { 
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
        final loginListener = Provider.of<LoginListener>(context,listen: false);
       
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Navbar(), section1(context,loginListener)
           
           
            
            ],
        ),
      ),
    );
  }

  section1(BuildContext context,loginListener) {
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
                          onPressed: () {
                             loginListener.updateStatus(state: UserState.Authenticated);
                          },
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
