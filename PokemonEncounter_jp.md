
画面遷移について色々と複雑で冒険できないと考えている人が多いと思いますが、
Dartの画面繊維はAnimationから派生してきたもので簡単にカスタマイズできます。

90年代のゲーム風画面遷移を実装していきます。
画面遷移、自体の説明は本家が一流の説明をしてくれるので省きます

<https://flutter.dev/docs/cookbook/navigation/navigation-basics>

#1.Router
MaterialPageRouterの構成を参考に
Routeの継承を行います

<script src="https://gist.github.com/gentle-ohige/2d57cc5a20d1f5a045d099e96c5360cd.js"></script>

#2.TransitionAnimatedWidget
アニメーション遷移時にbuildTransitionsが繰り返し呼び出され、
animationの値が更新されます。
AnimatedWidgetを継承したクラスを作成します。

childには遷移先の画面が入っており、
ClipPathを利用してchildの描画箇所を制御します

#3.SpliteScreen
画面をDotに分割していき、Dotごとに描画判別を行いPathに追加します。

#4.HitTest
画面をxy図形に見立て、一次関数の式から描画を判別して行きます。
重要な処理となります。
