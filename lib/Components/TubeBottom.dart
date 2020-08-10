import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:second_project/game_controller.dart';

class TubeBottom{
   final GameController gameController;
   double speed;
   Rect tubeRect;
   Sprite tubeSprite;

   TubeBottom(this.gameController,height,gap){
     speed = 3;
     tubeSprite = Sprite("pipe-bottom.png");
     tubeRect = Rect.fromLTWH(gameController.screenSize.width,
         height + gap,
         gameController.tileSize * 2,
         gameController.screenSize.height - height - gap);
   }

   void render(Canvas c){
     tubeSprite.renderRect(c, tubeRect);

   }
   void update(double t){
     tubeRect = tubeRect.translate(-gameController.tileSize * t * speed, 0);
   }

}