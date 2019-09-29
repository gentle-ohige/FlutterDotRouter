import 'package:flutter/material.dart';
import 'package:flutter_app/DotRoute/dot_clipper.dart';


class DotAnimation extends AnimatedWidget {

  Animation<double> get rotation => listenable;
  final Widget child;

  DotAnimation({
    Key key,
    @required Animation<double> animation,
    this.child,
  }):super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DotClipper(animationValue: rotation.value,),
      child: child,
    );
  }

}

