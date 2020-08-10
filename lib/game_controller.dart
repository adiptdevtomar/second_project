import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:second_project/Components/Pipes.dart';
import 'package:second_project/Components/TubeBottom.dart';
import 'package:second_project/Components/background.dart';
import 'package:second_project/Components/high_score.dart';
import 'package:second_project/Components/score_text.dart';
import 'package:second_project/Components/start_text.dart';
import 'package:second_project/pipe_spawner.dart';
import 'package:second_project/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Components/Player.dart';
import 'Components/TubeTop.dart';

class GameController extends Game{

  final SharedPreferences storage;
  Size screenSize;
  double tileSize;
  Bird bird;
  State state;
  TubeTop tubeTop;
  TubeBottom tubeBottom;
  List<Pipes> pipes;
  PipeSpawn pipeSpawn;
  Background background;
  StartText startText;
  ScoreText scoreText;
  int score;
  HighScore highScore;
  Offset offset1;
  Offset offset2;
  Offset offset3;
  Offset offset4;

  GameController(this.storage){
    initialize();
  }

  initialize() async {
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    bird = Bird(this,screenSize.width / 2,screenSize.height / 2);
    state = State.menu;
    pipes = List<Pipes>();
    score = 0;
    pipeSpawn = PipeSpawn(this);
    startText = StartText(this);
    highScore = HighScore(this);
    scoreText = ScoreText(this);
  }

  void render(Canvas c){
    background.render(c);
    if (state == State.playing){
      pipes.forEach((Pipes pipes) {
        pipes.render(c);
      });
      scoreText.render(c);
    }
    else{
      highScore.render(c);
      startText.render(c);
    }
    bird.render(c);
  }
  void update(double t){
    if (state == State.playing){
      pipeSpawn.update(t);
      pipes.forEach((Pipes pipes){
        pipes.update(t);
      });
      scoreText.update(t);
      pipes.removeWhere((Pipes pipe) => pipe.offScreen == true);
      bird.update(t);
    }
    else{
      highScore.update(t);
      startText.update(t);
    }
  }

  void resize(Size size){
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void onTapDown(TapDownDetails d){
    Flame.audio.play("jump.mp3",volume: 0.4);
    if(state == State.menu){
      state = State.playing;
      bird.speed = -10;
    }
    else{
      bird.speed = -10;
    }
  }

  void checkPipe(){
    offset1 = Offset(bird.spriteComponent.x + tileSize/3,bird.spriteComponent.y + tileSize/3);
    offset2 = Offset(bird.spriteComponent.x + tileSize/3,bird.spriteComponent.y - tileSize/3);
    offset3 = Offset(bird.spriteComponent.x - tileSize/3,bird.spriteComponent.y + tileSize/3);
    offset4 = Offset(bird.spriteComponent.x - tileSize/3,bird.spriteComponent.y - tileSize/3);
    pipes.forEach((Pipes pipe){
      if (pipe.tubeBottom.tubeRect.contains(offset1)){
        isDead();
      }
      else if(pipe.tubeTop.tubeRect.contains(offset1)){
        isDead();
      }
      else if(pipe.tubeBottom.tubeRect.contains(offset2)){
        isDead();
      }
      else if(pipe.tubeTop.tubeRect.contains(offset2)){
        isDead();
      }
      else if(pipe.tubeBottom.tubeRect.contains(offset3)){
        isDead();
      }
      else if(pipe.tubeTop.tubeRect.contains(offset3)){
        isDead();
      }
      else if(pipe.tubeBottom.tubeRect.contains(offset4)){
        isDead();
      }
      else if(pipe.tubeTop.tubeRect.contains(offset4)){
        isDead();
      }
    });
  }

  void spawnTube(){
    pipes.add(Pipes(this,DateTime.now().millisecond));
  }

  void isDead(){
    Flame.audio.play("crash.mp3",volume: 0.4);
    if (score > (storage.getInt("HighScore") ?? 0)){
      storage.setInt("HighScore", score);
    }
    initialize();
  }
}
