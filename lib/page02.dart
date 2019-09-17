
import 'package:flutter/material.dart';


class Page02 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       backgroundColor: Colors.blue,
       body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Colors.transparent,
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                    'PAGE_02',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.yellowAccent)
                ),
              )
            ],
          )
      ),
    );
  }
}