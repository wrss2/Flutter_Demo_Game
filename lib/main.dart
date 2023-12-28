import 'dart:math';

import 'package:Endless_Runer_Demo/airship.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(GameWidget(game:TestGame()));
}


class TestGame extends FlameGame with TapDetector {

  late SpriteAnimationComponent crow;
  Vector2 gravity = Vector2(0,30);

  @override
  void onLoad() async{
    super.onLoad();
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
      add(mountainBackground);  

      final crowAnimation = await loadSpriteAnimation('crow350x400.png', 
        SpriteAnimationData.sequenced(amount: 12, amountPerRow: 4, stepTime: 0.1, textureSize: Vector2(350,400))
      );

      crow  = SpriteAnimationComponent(
        animation: crowAnimation,
        anchor: Anchor.center,
        position:size/2,
        size: Vector2(size.y*350/400,size.y)*0.5
      );

      add(crow);

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
