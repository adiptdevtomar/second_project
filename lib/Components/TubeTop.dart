import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:second_project/game_controller.dart';

class TubeTop {
  final GameController gameController;
  double speed;
  Rect tubeRect;
  double height;
  Sprite tubeSprite;

  TubeTop(this.gameController,height) {
    speed = 3;
    tubeSprite = Sprite("pipe-top.png");
    tubeRect = Rect.fromLTWH(
        gameController.screenSize.width,
        0,
        gameController.tileSize * 2,
        height);
  }

  void render(Canvas c) {
    tubeSprite.renderRect(c, tubeRect);
  }

  void update(double t) {
    tubeRect = tubeRect.translate(-gameController.tileSize * t * speed, 0);
  }
}
