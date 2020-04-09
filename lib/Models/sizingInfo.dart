
import 'package:flutter/material.dart';

class SizingInfo{
  final BuildContext context;
  var height;
  var width;

  SizingInfo({this.context});
   setSizes(){
    height= MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }


}