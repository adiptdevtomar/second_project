import 'dart:math';

import 'package:flutter/material.dart';
import 'package:second_project/Components/TubeBottom.dart';
import 'package:second_project/Components/TubeTop.dart';
import 'package:second_project/game_controller.dart';

class Pipes {
  final GameController gameController;
  int id;
  Random rand;
  double gap;
  double minHeight;
  double maxHeight;
  double topHeight;
  TubeBottom tubeBottom;
  TubeTop tubeTop;
  bool offScreen;
  List l;

  Pipes(this.gameController, i) {
    l = List();
    rand = Random();
    offScreen = false;
    id = i;
    gap = gameController.tileSize * 5;
    minHeight = gameController.tileSize * 1;
    maxHeight = gameController.tileSize * 10;
    topHeight = minHeight + rand.nextDouble() * maxHeight;
    tubeTop = TubeTop(gameController, topHeight);
    tubeBottom = TubeBottom(gameController, topHeight, gap);
  }

  void render(Canvas c) {
    tubeBottom.render(c);
    tubeTop.render(c);
  }

  void update(double t) {
    tubeTop.update(t);
    tubeBottom.update(t);
    if (tubeTop.tubeRect.bottomRight.dx < 0) {
      offScreen = true;
    }
    if (!l.contains(id)) {
      if (tubeTop.tubeRect.bottomRight.dx <
          gameController.screenSize.width / 2) {
        gameController.score += 1;
        l.add(id);
      }
    }
  }
}
