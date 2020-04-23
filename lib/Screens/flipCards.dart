import 'package:Quiz_web/Services/Providers/reviewerProvider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:flip_card/flip_card.dart';
import 'package:provider/provider.dart';

class FlipCards extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   
    final reviewerProvider = Provider.of<ReviewerProvider>(context,listen: false);
    final db = Firestore.instance;
    final _pageViewController =
        PageController(initialPage: reviewerProvider.pageCounter);

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
              color: Color.fromRGBO(229,229,229,1),
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: StreamBuilder<QuerySnapshot>(
                  stream: db.collection('quiz1').orderBy('order').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return PageView(
                          controller: _pageViewController,
                          children: snapshot.data.documents
                              .map((doc) => buildCard(
                                  context, doc, _pageViewController))
                              .toList());
                    } else {
                      return Center(child: CircularProgressIndicator(
               
                      ));
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Navbar(),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .5,
            left: 0,
            child: Container(
              height: 250,
              child: Center(
                child: ButtonTheme(
                  minWidth: 50,
                  height: 50,
                  buttonColor: Colors.redAccent,
                  child: RaisedButton.icon(
                      onPressed: () {
                        reviewerProvider.goBack(controller: _pageViewController);
                      
                      },
                      icon: Icon(Icons.arrow_left),
                      label: Text('')),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: MediaQuery.of(context).size.height * .5,
            child: Container(
              height: 250,
              width: 70,
              child: Center(
                child: ButtonTheme(
                  height: 50,
                  buttonColor: Colors.redAccent,
                  child: RaisedButton.icon(
                      onPressed: () {
                    reviewerProvider.goForward(controller: _pageViewController);
                      
                      },
                      icon: Icon(Icons.arrow_right),
                      label: Text('')),
                ),
              ),
            ),
          )
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
      return FlipCard(
        direction: FlipDirection.VERTICAL, // default
        front: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 250),
          child: Container(
            width: MediaQuery.of(context).size.width * .7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
            ),
            height: 250,
            child: Center(
                child: Text(doc.data['question'],
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))),
          ),
        ),
        back: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 250),
          child: Container(
            width: MediaQuery.of(context).size.width * .7,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
            ),
            child: Center(
                child: Text(
              doc.data['answer'].toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      );
    }
  }
}
