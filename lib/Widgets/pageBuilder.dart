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
    pusher();

    return Container();
  }

  pusher() async {
    await Navigator.pushNamed(context, widget.page);
  }


}
