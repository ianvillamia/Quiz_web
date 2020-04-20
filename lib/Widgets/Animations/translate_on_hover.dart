import 'package:flutter/material.dart';
import 'package:Quiz_web/Models/animationTypes.dart';
class TranslateOnHover extends StatefulWidget {
  final Widget child;
  final Color colorChange;
  final animationType;
  // You can also pass the translation in here if you want to
  TranslateOnHover(
      { @required this.child,
       this.colorChange,
       @required this.animationType});
  @override
  _TranslateOnHoverState createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
  var hoverTransform = Matrix4.identity()..translate(0, -10, 0);
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    if (widget.animationType == AnimationType.moveUp) {
      hoverTransform = Matrix4.identity()..translate(0, -10, 0);
    }
    if(widget.animationType == AnimationType.changeColor){
          hoverTransform = Matrix4.identity()..translate(0, 0, 0);
    }
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: widget.child,
              
        decoration: BoxDecoration(
          color: _hovering ? widget.colorChange : null,
        ),
        transform: _hovering ? hoverTransform : nonHoverTransform,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}
