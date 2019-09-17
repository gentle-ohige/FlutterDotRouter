
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math_V;
import 'dart:math';

class DotClipper extends  CustomClipper<Path> {
  double animationValue;
  double dotSize;
  DotClipper({this.animationValue, this.dotSize = 24});

  @override
  Path getClip(Size size) {

    int widthDot = (size.width / dotSize).ceil();
    int heightDot = (size.height.ceil() / dotSize).ceil();
    int total = widthDot * heightDot;

    List<Dot> dotList = List.generate(
        total,
            (int index) => Dot(
            size: dotSize,
            row: index % widthDot, column: (index / widthDot).floor()
        )
    );


    Path path = Path();
    dotList.forEach((dot){
      if(dotHitTest(size: size, value: animationValue, dotRect: dot.rect))path.addRect(dot.rect);
    });
    return path;
  }

  bool dotHitTest ({Size size, double value, Rect dotRect}) {

    Offset center = size.center(Offset.zero);
    double rad =  math_V.radians(- 90 + 180 * value);
    double y =  tan(rad) * (dotRect.center.dx - center.dx)  + center.dy ;

    if(center.dx > dotRect.center.dx) {
      if( y <  dotRect.center.dy) return true;
      else return false;
    } else {
      if( y >  dotRect.center.dy) return true;
      else return false;

    }
  }

  @override
  bool shouldReclip(DotClipper oldClipper) {
    return  animationValue != oldClipper.animationValue;
  }

}

class Dot {
  double size;
  int row;
  int column;

  Dot({this.size, this.column, this.row});

  Rect get rect => Rect.fromLTWH(row * size, column * size, size, size);
}


