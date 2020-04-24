import 'package:flutter/material.dart';
class AddSubjects extends StatelessWidget {
  const AddSubjects({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
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
                      // Section1(), //
                      // Section2(),
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