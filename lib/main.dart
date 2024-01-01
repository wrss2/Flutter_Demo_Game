import 'dart:math';
import 'dart:ui';

import 'package:Endless_Runer_Demo/airship.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart' hide Image;


void main() {
  runApp(GameWidget(game:TestGame()));
}


class TestGame extends FlameGame with TapDetector {

  late SpriteAnimationComponent crow;  
  late SpriteAnimationComponent soldier;
  late SpriteAnimationComponent soldier2;
  late SpriteAnimationComponent fight1;
  late SpriteAnimationComponent fight2;
  late SpriteComponent backChees;
  late SpriteComponent backChees2;
  late SpriteComponent backChees3;


  Vector2 gravity = Vector2(0,30);

  @override
  void onLoad() async{
    super.onLoad();
   // FlameAudio.play("subway.mp3");
    FlameAudio.bgm.play('subway.mp3');
    ParallaxComponent mountainBackground = await loadParallaxComponent(
      [
        ParallaxImageData('sky.png'),
        ParallaxImageData('clouds_bg.png'),
        ParallaxImageData('glacial_mountains.png'),
        ParallaxImageData('clouds_mg_1.png'),    
        ParallaxImageData('cloud_lonely.png'),            
        // ParallaxImageData('clouds_mg_2.png'),    
        // ParallaxImageData('clouds_mg_3.png'),                        
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.6, 1.0));

    ParallaxComponent mountainBackground2 = await loadParallaxComponent(
      [
        ParallaxImageData('mk2_04.png'),
        // ParallaxImageData('clouds_bg.png'),
        // ParallaxImageData('glacial_mountains.png'),
        // ParallaxImageData('clouds_mg_1.png'),    
        // ParallaxImageData('cloud_lonely.png'),            
        // ParallaxImageData('clouds_mg_2.png'),    
        // ParallaxImageData('clouds_mg_3.png'),                        
      ],
      position:  Vector2(0, 0),
      size: Vector2(320*2, 250),
      baseVelocity: Vector2(200, 0),
      velocityMultiplierDelta: Vector2(1.6, 1.0));



      add(mountainBackground2);  

      final crowAnimation = await loadSpriteAnimation('crow350x400.png', 
        SpriteAnimationData.sequenced(amount: 12, amountPerRow: 4, stepTime: 0.1, textureSize: Vector2(350,400))
      );

      final soldierAnimation1 = await loadSpriteAnimation('soldier2.png', 
        SpriteAnimationData.sequenced(amount: 14, amountPerRow: 7, stepTime: 0.1, textureSize: Vector2(27,45))
      );

      final soldierAnimation2 = await loadSpriteAnimation('soldier2.png', 
        SpriteAnimationData.sequenced(amount: 7, amountPerRow: 7, stepTime: 0.1, textureSize: Vector2(27,45))
      );

      final fightAnimation2 = await loadSpriteAnimation('test_img.png', 
        SpriteAnimationData.sequenced(amount: 41, amountPerRow: 41, stepTime: 0.1, textureSize: Vector2(65,65))
      );


      crow  = SpriteAnimationComponent(
        animation: crowAnimation,
        anchor: Anchor.center,
        position:size/2,
        size: Vector2(size.y*350/400,size.y)*0.5
      );


      soldier  = SpriteAnimationComponent(
        animation: soldierAnimation1,
        anchor: Anchor.center,
        position:size/2,
        size: Vector2(size.y*27/40,size.y)*0.5
      );

      fight2  = SpriteAnimationComponent(
        animation: fightAnimation2,
        anchor: Anchor.center,
        position:Vector2(1300,600),
        size: Vector2(size.y*65/65,size.y)*0.5
      );      



      Image soldierImg = await images.load('soldier4.png');
      Image fightImg = await images.load('fight1.png');
      Image backCheesImg = await images.load('back_chees.png');
      Image towerBack = await images.load('mk2_08.png');
      Image towerBack2 = await images.load('mk2_12.png');

      final spriteSheet = SpriteSheet(
        image: soldierImg,
        srcSize: Vector2(27,45),
      );

      final spriteSheet2 = SpriteSheet(
        image: fightImg,
        srcSize: Vector2(58,61),
      );  

      final backCheesSheet = SpriteSheet(
        image: backCheesImg,
        srcSize: Vector2(320,200),
      );            

      final animation2 = SpriteAnimation.fromFrameData(
        soldierImg, 
        SpriteAnimationData([
          spriteSheet.createFrameDataFromId(1, stepTime: 0.1), // by id
          spriteSheet.createFrameDataFromId(2, stepTime: 0.1), // by id
          spriteSheet.createFrameDataFromId(3, stepTime: 0.1), // by id
          spriteSheet.createFrameDataFromId(4, stepTime: 0.1), // by id
          spriteSheet.createFrameDataFromId(5, stepTime: 0.1), // by id
          spriteSheet.createFrameDataFromId(6, stepTime: 0.1), // by id
          spriteSheet.createFrameDataFromId(7, stepTime: 0.1), // by id
        ]),
      );

      soldier2  = SpriteAnimationComponent(
        animation: animation2,
        anchor: Anchor.center,
        position:size/2,
        size: Vector2(size.y*27/40,size.y)*0.5
      );


      fight1  = SpriteAnimationComponent(
        animation: animation2,
        anchor: Anchor.center,
        position:size/2,
        size: Vector2(size.y*58/61,size.y)*0.5
      );

      backChees  = SpriteComponent()
        ..sprite = await loadSprite('back_chees_03.png')
        ..size = Vector2(320*4, 200*4)
        ..position = Vector2(640, 300);


      backChees2  = SpriteComponent()
        ..sprite = await loadSprite('mk2_08.png')
        ..size = Vector2(320*2, 250);  


      backChees3  = SpriteComponent()
        ..sprite = await loadSprite('mk2_12.png')
        ..size = Vector2(320*2, 200)
        ..position = Vector2(0, 250);


      //add(crow);
      add(backChees2);
      add(backChees3);

      add(backChees);
      add(fight2);



      for (var i = 0; i < 5; i++) {
        add(AirShip(i));
      }

      // add(SpriteComponent(
      //   anchor: Anchor.center,
      //   position:size/2,
      //   sprite:await loadSprite('crow350x400.png', srcSize:Vector2(350, 400))
      // ));  

  }

   @override
   void update(double dt){
     super.update(dt);
     if(crow.y > size.y && crow.y > 0){
        crow.position.y = -100;
        gravity.y = 0;
        crow.position.x =   Random().nextInt(500).toDouble();
     }

     gravity.y += 0.2;
     crow.position += gravity * dt;

    //  print('update1 $gravity.y');
    //  print('update2 $crow.position');

   }

  @override
  void onTapUp(TapUpInfo info){

     gravity.y -= 50;
     print("TapUpInfo");

     super.onTapUp(info);

  }

}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Test Demo APP'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//    List<Widget> dynamicWidgets = [];

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//       dynamicWidgets.add(Text('Dynamically Added Widget $_counter'));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Colors.blue, // Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: dynamicWidgets
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
