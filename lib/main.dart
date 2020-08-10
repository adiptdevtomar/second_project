import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  Flame.images.loadAll(<String>[
    "background.png",
    "Bird.png",
    "pipe-bottom.png",
    "pipe-top.png"
  ]);

  Flame.audio.loadAll(<String>[
    "jump.mp3",
    "crash.mp3"
  ]);

  await SharedPreferences.getInstance().then((val){
    GameController gameController = GameController(val);
    runApp(gameController.widget);

    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = gameController.onTapDown;
    flameUtil.addGestureRecognizer(tapper);
  });
}
