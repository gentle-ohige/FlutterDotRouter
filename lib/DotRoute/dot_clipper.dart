import 'dot.dart';
import 'dot_hit_test.dart';
import 'package:flutter/material.dart';

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
      if(DotHitTest.rotate(size: size, value: animationValue, dotRect: dot.rect))
        path.addRect(dot.rect);
    });

    return path;
  }

  @override
  bool shouldReclip(DotClipper oldClipper) {
    return  animationValue != oldClipper.animationValue;
  }

}
