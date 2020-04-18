import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
   color: Colors.blue,
      child: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: size.width*.3,
        ),
      ),
    );
  }
  }