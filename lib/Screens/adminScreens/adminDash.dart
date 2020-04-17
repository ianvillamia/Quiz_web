import 'package:Quiz_web/Models/animationTypes.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/Animations/hover_extensions.dart';
import 'package:Quiz_web/Widgets/Animations/translate_on_hover.dart';
import 'package:provider/provider.dart';
import 'package:Quiz_web/Models/userModel.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height * .5;
    final double itemWidth = size.width * .4;

    return Scaffold(
        // appBar: buildAppBar(context),
        // drawer: buildDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildContainer(
                      image: "assets/homer.png",
                      text: 'Users',
                      function: dosomething(),
                      subtext: "Create, Update, Read, Delete any user"),
                  buildContainer(
                      image: "assets/files.png",
                      text: 'Files',
                      function: dosomething(),
                      subtext: "Edit downloadbles in QuizApp"),
                  buildContainer(
                      image: "assets/add-icon.png",
                      text: 'Subjects',
                      function: dosomething(),
                      subtext: 'Create, Update, Read, Delete any Subject'),
                  buildContainer(
                      image: "assets/multiple.png",
                      text: 'Quizzes',
                      function: dosomething(),
                      subtext: 'Create, Update, Read, Delete any Quiz'),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildContainer(
                      image: "assets/chart.png",
                      text: 'Charts',
                      function: dosomething(),
                      subtext: 'Graphs and such'),
                ],
              ),
            ],
          ),
        ));
  }

  buildContainer(
      {@required String image,
      @required String text,
      @required Function function,
      @required String subtext}) {
    return TranslateOnHover(
      colorChange: null,
      animationType: AnimationType.moveUp,
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: () => function,
        child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Container(
                  width: 90,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(image))),
                ),
                Text(text,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                Align(
                  alignment: Alignment.center,
                                  child: Text(
                    subtext,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
      ),
    ).showCursorOnHover;
  }

  dosomething() {
    print('tapped');
  }
}
