import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
class AnswerCard extends StatelessWidget {
  const AnswerCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return ExpandableNotifier(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "click",
                        style: Theme.of(context).textTheme.body2,
                      )),
              
                  expanded: Text('hehe'),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}