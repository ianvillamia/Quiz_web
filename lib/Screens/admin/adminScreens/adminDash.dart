import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
          body: Row(
        children: <Widget>[
          //sidebar
          Container(
            width: size.width * .2,
            height: size.height,
            color: Color.fromRGBO(24, 24, 24, 1),
            child: Center(child: Text('Sidebar',style:TextStyle(color: Colors.white))),
          ),
          //body
          Scrollbar(
            child: Container(
              width: size.width * .8,
              height: size.height,
              color: Color.fromRGBO(235, 236, 240, 1),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // CardBuilder()
                      Section1(), //
                      Section2(),
                      ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
/*-------------------------------------------------------------------------------------*/

//section2
class Section2 extends StatelessWidget {
  const Section2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .8,
      height: size.height * .6,
    //  color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 350,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage('assets/bandwith.png'),
                    fit: BoxFit.cover)),
          ),
            Container(
            width: 350,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage('assets/download-count.png'),
                    fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }
}

///cards for top

class Section1 extends StatelessWidget {
  const Section1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .8,
      height: size.height * .3  ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CardBuilder(
            asssetImage: 'assets/user-icon.png',
            mainText: 'Users',
            number: 250,
            subText: 'Today',
            route: '/adminUsers',
          ),
          CardBuilder(
            asssetImage: 'assets/subjects-icon.png',
            mainText: 'Subjects',
            number: 40,
            subText: 'track subjects',
            route: '/adminSubjects',
          ),
          CardBuilder(
            asssetImage: 'assets/quiz-icon.png',
            mainText: 'Quizzes',
            number: 10,
            subText: 'track quizzes',
            route: '/adminQuizzes',
          ),
        ],
      ),
    );
  }
}

class CardBuilder extends StatelessWidget {
  //this is for the thing
  final String asssetImage;
  final String mainText;
  final int number;
  final String subText;
  final String route;
  CardBuilder(
      {@required this.asssetImage,
      @required this.mainText,
      @required this.number,
      @required this.subText,
      @required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      // /  color: Colors.orangeAccent,
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              // color: Colors.red,
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                   Navigator.pushNamed(context, route);
                  },
                  child: Container(
                      width: 200,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              mainText,
                              style: TextStyle(color: Colors.grey),
                            ),
                            //  Text('Current Users'),
                            Text(
                              number.toString(),
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 200,
                              height: 1,
                              color: Colors.grey,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                subText,
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
          Positioned(
              top: 5,
              child: Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(asssetImage), fit: BoxFit.cover)),
              ))

          // Positioned(
          //   left: 20,child: )
        ],
      ),
    );
  }
}

