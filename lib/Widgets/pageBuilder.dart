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
        pusher();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return  Container();
  }
  pusher()async{
    await  Navigator.pushNamed(context, widget.page);
  }
}