import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:second_project/game_controller.dart';

class Bird {

  final GameController gameController;
  double angle;
  bool isDead;
  Rect birdRect;
  Position velocity;
  double speed;
  double acceleration;
  Sprite birdSprite;
  SpriteComponent spriteComponent;

  Bird(this.gameController, double x, double y) {

    angle = 0;
    acceleration = 25;
    speed = 0;
    velocity = Position(20,speed);
    birdSprite = Sprite("Bird.png");
    spriteComponent = SpriteComponent.fromSprite(gameController.tileSize * 1.5,
        gameController.tileSize * 1.5, birdSprite);
    spriteComponent.x = x;
    spriteComponent.y = y;
    spriteComponent.angle = 0;
    spriteComponent.anchor = Anchor.center;
  }

  void render(Canvas c) {
    spriteComponent.render(c);
  }

  void update(double t) {
    if(spriteComponent.y < gameController.screenSize.height && spriteComponent.y > 0){
      gameController.checkPipe();
      speed = speed + acceleration * t;
      spriteComponent.y += speed;
      velocity = Position(10,speed);
      spriteComponent.angle = velocity.angle();
    }
    else{
      gameController.isDead();
    }
  }
}
