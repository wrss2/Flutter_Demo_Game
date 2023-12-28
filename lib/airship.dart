
import 'dart:math';

import 'package:flame/components.dart';
import 'main.dart';

class AirShip extends SpriteComponent with HasGameRef<TestGame>{
  var iter;
  late SpriteComponent test;

  AirShip(int i){
    this.iter = i;
  }

  @override 
  void onLoad()  async{
      await super.onLoad();
      var rand =   Random().nextInt(this.iter + 300);
      sprite = await gameRef.loadSprite('airship.png');
      size = Vector2(gameRef.size.y * 800/469 , gameRef.size.y)*0.15;
      flipHorizontallyAroundCenter();
      position = Vector2(gameRef.size.x* .95 , rand.toDouble());

      // test  = SpriteComponent(
      //   anchor: Anchor.center,
      //   position:size/2,
      //   size: Vector2(size.y*350/400,size.y)*0.5,
      //   sprite: sprite
      // );

      // add(test);
     
  }


  @override
  void update(double dt){
    super.update(dt);

   //var rand =   Random().nextInt(this.iter + 500);
    x = x - 100 * dt;
  //  y = gameRef.size.y/2-50  + 130*this.iter -270;

  //  print(rand);
    //     x = Random().nextInt(x.toInt()) + size.x - 100 * dt;
    // y = gameRef.size.y/2-50;

   // print('ship $x');
    if(x < 0){
       x = gameRef.size.x + 300;
       y =  Random().nextInt(this.iter + 300).toDouble();
    }



  }
}