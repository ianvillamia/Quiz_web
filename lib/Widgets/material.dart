import 'package:flutter/material.dart';

CustomMaterialButton(
    {@required Function function,
    @required Color color,
    @required Color hoverColor,
    @required String text}) {
  return MaterialButton(
    minWidth: 100,
    hoverColor: hoverColor,
    textColor: Colors.white,
    onPressed: () => function,
    color: color,
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
    ),
  );
}
