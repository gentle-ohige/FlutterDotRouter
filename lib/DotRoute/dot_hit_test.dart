import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as math_V;

class DotHitTest{
  static bool rotate ({Size size, double value, Rect dotRect}) {

    Offset center = size.center(Offset.zero);
    double rad = math_V.radians(- 90 + 180 * value);
    double y = tan(rad) * (dotRect.center.dx - center.dx)  + center.dy ;

    if(center.dx > dotRect.center.dx) {
      if( y < dotRect.center.dy) return true;
      else return false;
    } else {
      if( y > dotRect.center.dy) return true;
      else return false;
    }
  }
}