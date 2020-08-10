import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_project/game_controller.dart';

class StartText {
  final GameController gameController;
  TextPainter textPainter;
  Offset position;

  StartText(this.gameController) {
    textPainter = TextPainter(
        textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    position = Offset.zero;
  }

  void render(Canvas c) {
    textPainter.paint(c, position);
  }

  void update(double t) {
    textPainter.text = TextSpan(
        text: "Tap to Start",
        style: TextStyle(
            fontSize: 50.0,
            color: Colors.black
        )
    );
    textPainter.layout();
    position = Offset(
        (gameController.screenSize.width / 2) - (textPainter.width / 2),
        (gameController.screenSize.height * 0.7) - (textPainter.height / 2)
    );
  }
}