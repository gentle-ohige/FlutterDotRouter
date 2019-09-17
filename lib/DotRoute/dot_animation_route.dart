import 'package:flutter/material.dart';

import 'dot_animation.dart';

class DotAnimationRoute<T> extends PageRoute<T> {
  Widget child;
  DotAnimationRoute({
    @required this.child,
    RouteSettings settings,
    bool fullscreenDialog = false,

  }) : assert(child != null),
        assert(fullscreenDialog != null),
        assert(opaque),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(seconds: 2);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
      double begin = 0;
      double end = 1;
      var curve = Curves.easeInOutSine;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return DotAnimation(
        rotation: animation.drive(tween),
        child: child,
      );
  }
}
