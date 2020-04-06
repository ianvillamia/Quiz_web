import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:flip_card/flip_card.dart';

class Reviewer extends StatelessWidget {
  const Reviewer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;
    final _pageViewController = PageController(initialPage: 1);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * .2,
            child: Container(
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('This is Some Heading',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Text('This is Some sub Heading',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .4,
            child: Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: db.collection('quiz1').orderBy('order').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Scrollbar(
                      child: PageView(
                          controller: _pageViewController,
                          children: snapshot.data.documents
                              .map((doc) =>
                                  buildCard(context, doc, _pageViewController))
                              .toList()),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Navbar(),
          ),
          // Positioned(
          //     top: MediaQuery.of(context).size.height * .5,
          //     right: 0,
          //     child: Timer())
        ],
      ),
    );
  }

  Widget buildCard(
      BuildContext context, DocumentSnapshot doc, PageController controller) {
    print(doc.documentID);
    var type = doc.data['type'];
    if (type == "header") {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 250,
              child: Center(
                child: RaisedButton.icon(
                    color: Colors.blueAccent,
                    onPressed: () {
                      controller.previousPage(
                          duration: Duration(seconds: 1), curve: Curves.easeIn);
                    },
                    icon: Icon(Icons.arrow_left),
                    label: Text('')),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              color: Colors.black,
              child: FlipCard(
                direction: FlipDirection.VERTICAL, // default
                front: Container(
                  
                  width: MediaQuery.of(context).size.width * .8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                   color: Colors.white,
                  ),
                  height: 250,
                  child: Center(child: Text(doc.data['question'])),
                ),
                back: Container(
                  
                  width: MediaQuery.of(context).size.width * .8,
                  height: 250,
                  decoration: BoxDecoration(
              
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                  ),
                  child: Center(child: Text(doc.data['answer'].toString())),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 250,
              child: Center(
                child: RaisedButton.icon(
                    color: Colors.blueAccent,
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(seconds: 1), curve: Curves.easeIn);
                    },
                    icon: Icon(Icons.arrow_right),
                    label: Text('')),
              ),
            ),
          ],
        ),
      );
    }
  }
}
