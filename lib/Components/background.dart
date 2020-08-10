import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:second_project/game_controller.dart';

class Background {
  final GameController gameController;
  Sprite bgSprite;
  Rect background;

  Background(this.gameController) {
    bgSprite = Sprite("background.png");
    background = Rect.fromLTWH(
        0,
        -((gameController.tileSize * 31.63) - gameController.screenSize.height),
        gameController.tileSize * 10,
        gameController.tileSize * 31.63);
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, background);
  }
}
