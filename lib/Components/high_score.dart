import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_project/game_controller.dart';

class HighScore {
  final GameController gameController;
  TextPainter textPainter;
  Offset position;

  HighScore(this.gameController) {
    textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    position = Offset.zero;
  }

  void render(Canvas c) {
    textPainter.paint(c, position);
  }

  void update(double t) {
    int highScore = gameController.storage.getInt("HighScore") ?? 0;
    textPainter.text = TextSpan(
        text: "HighScore: $highScore",
        style: TextStyle(
            fontSize: 40.0,
            color: Colors.black
        )
    );
    textPainter.layout();
    position = Offset(
        (gameController.screenSize.width / 2) - (textPainter.width / 2),
        (gameController.screenSize.height * 0.2) - (textPainter.height / 2)
    );
  }
}