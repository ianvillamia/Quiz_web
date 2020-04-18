import 'package:flutter/material.dart';

class PageBuilder extends StatefulWidget {
  final String page;
  PageBuilder({@required this.page});

  @override
  _PageBuilderState createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() {
     Navigator.pushNamed(context, widget.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    // pusher();

    return Container();
  }

  pusher() async {
    await Navigator.pushNamed(context, widget.page);
  }
  //   Future popLog(context) async {
  //   Navigator.popUntil(
  //       context, ModalRoute.withName(Navigator.defaultRouteName));
  // }
}
