import 'package:flutter/material.dart';
import 'package:flutter_app/DotRoute/dot_clipper.dart';


class DotAnimation extends AnimatedWidget {

  DotAnimation({
    Key key,
    @required Animation<double> rotation,
    this.transformHitTests = true,
    this.child,
  }):super(key: key, listenable: rotation);

  Animation<double> get rotation => listenable;
  final bool transformHitTests;
  final Widget child;


  @override
  Widget build(BuildContext context) {

    return ClipPath(
      clipper: DotClipper(animationValue: rotation.value,),
      child: child,
    );

  }
}

