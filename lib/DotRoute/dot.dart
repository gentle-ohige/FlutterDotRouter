import 'package:flutter/material.dart';

class Dot {

  double size;
  int row;
  int column;

  Rect get rect => Rect.fromLTWH(row * size, column * size, size, size);

  Dot({this.size, this.column, this.row});

}


