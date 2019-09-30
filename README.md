Flutterで90年代のゲーム風画面遷移を実装していきます

<img src="https://github.com/gentle-ohige/FlutterDotRouter/blob/samples/movies/sample.gif" width="360">

画面遷移実装について本家が一流の説明をしてくれるので省きます

[Navigate to a new screen and back](https://flutter.dev/docs/cookbook/navigation/navigation-basics)

実装部分の浅い層を確認するだけでも、Flutterの画面遷移はAnimation機能を
そのまま利用していることが理解できます。
アニメーションについて見識があれば、機能を拡張していくことで
容易にカスタマイズできると思います。

#1.Router
MaterialPageRouterの構成を参考に
Routeの継承を行います

```.dart
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
```


#2.TransitionAnimatedWidget
アニメーション遷移時にbuildTransitionsが繰り返し呼び出され、
animationの値が更新されます。
AnimatedWidgetを継承したクラスを作成します。

```.dart
class DotAnimation extends AnimatedWidget {

  DotAnimation({
    Key key,
    @required Animation<double> animation,
    this.transformHitTests = true,
    this.child,
  }):super(key: key, listenable: animation);

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
```


childには遷移先の画面が入っており、
ClipPathを利用してchildの描画箇所を制御します

#3.SpliteScreen
画面をDotに分割していきます。

```.dart
class Dot {
  double size;
  int row;
  int column;

  Dot({this.size, this.column, this.row});

  Rect get rect => Rect.fromLTWH(row * size, column * size, size, size);
}
```

Dotごとに描画判別を行い、Pathに追加します。

```.dart
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
```


#4.HitTest
画面をxy図形に見立て、一次関数の式から描画を判別して行きます。
重要な処理となります。

```.dart
import 'package:vector_math/vector_math.dart' as math_V;
class DotHitTest{
  static bool rotate ({Size size, double value, Rect dotRect}) {

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
}
```

#5.最後に
線形関数を用いて様々な遷移アニメーションをカスタマイズしましょう。
https://github.com/gentle-ohige/FlutterDotRouter
Mediumに英語版を投稿する予定です。(Gistは正義)
