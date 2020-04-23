import 'package:Quiz_web/Services/Providers/reviewerProvider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Quiz_web/Widgets/navbar.dart';
import 'package:flip_card/flip_card.dart';
import 'package:provider/provider.dart';

class Reviewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reviewerProvider =
        Provider.of<ReviewerProvider>(context, listen: false);
    final db = Firestore.instance;
    int selected;
    final _pageViewController =
        PageController(initialPage: reviewerProvider.pageCounter);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            //actual quiz
            top: MediaQuery.of(context).size.height * .2,
            child: Container(
              color: Color.fromRGBO(229, 229, 229, 1),
              width: size.width,
              height: size.height*.8,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //topbar
                      Container(
                        width: size.width,
                        height: size.height * .1,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text('Question 1'),
                                  Text('0/2 points')
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  MaterialButton(
                                    elevation: 0,
                                    focusElevation: 0,
                                    highlightElevation: 0,
                                    hoverElevation: 0,
                                    color: Color.fromRGBO(232, 234, 246, 1),
                                    child: Text('Previous'),
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  MaterialButton(
                                    highlightElevation: 0,
                                    hoverElevation: 0,
                                    focusElevation: 0,
                                    elevation: 0,
                                    color: Color.fromRGBO(232, 234, 246, 1),
                                    child: Text('Next'),
                                    onPressed: () {},
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                     Container(
                       color: Colors.grey,
                       height: 3,
                     ),
                      Container(
                        width: size.width,
                       
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text('question'),
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  value: 1,
                                  groupValue: selected,
                                  onChanged: (val) {
                                    // changeSelectedValue(val);
                                  },
                                ),
                                Text(
                                  'First Choice',
                                  //  widget.choices[0],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  value: 2,
                                  groupValue: selected,
                                  onChanged: (val) async {
                                    // changeSelectedValue(val);
                                  },
                                ),
                                Text(
                                  'second choice',
                                  //  widget.choices[1],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                    value: 3,
                                    groupValue: selected,
                                    onChanged: (val) async {
                                      //   changeSelectedValue(val);
                                    }),
                                Text(
                                  'third choice',
                                  //   widget.choices[2],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  value: 4,
                                  groupValue: selected,
                                  onChanged: (val) async {
                                    //  changeSelectedValue(val);
                                  },
                                ),
                                Text(
                                  'fourth choice',
                                  //  widget.choices[3],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //body
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            //navbar duh
            top: 0,
            child: Navbar(),
          ),
        ],
      ),
    );
  }
}
