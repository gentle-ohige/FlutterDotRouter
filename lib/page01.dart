
import 'package:flutter/material.dart';
import 'package:flutter_app/page02.dart';
import 'DotRoute/dot_animation_route.dart';

class Page01 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.yellow,
      body:  Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).push(DotAnimationRoute(child:Page02()));
              },
              child: Text(
                  'PAGE_01',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueAccent)
              ),
            )
          ],
        )
      ),
    );
  }

}