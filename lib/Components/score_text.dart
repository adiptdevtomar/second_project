import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_project/game_controller.dart';

class ScoreText {
  final GameController gameController;
  TextPainter textPainter;
  Offset offset;

  ScoreText(this.gameController) {
    textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    offset = Offset.zero;
  }

  void render(Canvas c) {
    textPainter.paint(c, offset);
  }

  void update(double t) {
    if ((textPainter.text ?? "") != gameController.score.toString()) {
      textPainter.text = TextSpan(
          text: gameController.score.toString(),
          style: TextStyle(color: Colors.black, fontSize: 70.0));
    }
    textPainter.layout();

    offset = Offset(
        (gameController.screenSize.width / 2) - (textPainter.width / 2),
        (gameController.screenSize.height * 0.1) - (textPainter.height / 2));
  }
}
