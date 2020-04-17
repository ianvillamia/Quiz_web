import 'package:Quiz_web/Models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageBuilder extends StatefulWidget {
  final String page;
  PageBuilder({@required this.page});

  @override
  _PageBuilderState createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
 

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    if (user == null) {
      popLog(context);
    } else {
      pusher();
    }
    return Container();
  }

  pusher() async {
    await Navigator.pushNamed(context, widget.page);
  }

  Future popLog(context) async {
    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }
}
