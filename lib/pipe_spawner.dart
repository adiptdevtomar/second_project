import 'package:second_project/game_controller.dart';

import 'Components/Pipes.dart';

class PipeSpawn{
  final GameController gameController;
  int nextSpawn;
  int currentInterval = 1800;


  PipeSpawn(this.gameController){
    initialize();
  }

  initialize(){
    removePipes();
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  removePipes(){
    gameController.pipes.forEach((Pipes pipe) {
      pipe.offScreen = true;
    });
  }

  void update(double t){
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now >= nextSpawn){
      gameController.spawnTube();
      nextSpawn = now + currentInterval;
    }
  }


}