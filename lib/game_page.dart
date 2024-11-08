import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_flame/components/background.dart';
import 'package:flappy_bird_flame/components/bird.dart';
import 'package:flappy_bird_flame/components/bottom.dart';
import 'package:flappy_bird_flame/components/pipe.dart';
import 'package:flappy_bird_flame/components/pipe_manager.dart';
import 'package:flappy_bird_flame/components/score_widget.dart';
import 'package:flappy_bird_flame/constants.dart';
import 'package:flutter/material.dart';

class GamePage extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Bottom bottom;
  late PipeManager pipeManager;
  late ScoreWidget scoreWidget;

  int score = 0;
  bool isGameOver = false;

  incrementScore() {
    score += 1;
  }

  @override
  FutureOr<void> onLoad() {
    background = Background(size);
    add(background);

    bird = Bird();
    add(bird);

    bottom = Bottom();
    add(bottom);

    pipeManager = PipeManager();
    add(pipeManager);

    scoreWidget = ScoreWidget();
    add(scoreWidget);
  }

  void gameOver() {
    if (isGameOver) return;
    // FlameAudio.play('die.wav');
    isGameOver = true;
    pauseEngine();

    showDialog(
      context: buildContext!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Game Over"),
          content: Text("Hightest Score: $score"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetGame();
                },
                child: const Text("Restart"))
          ],
        );
      },
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
    resumeEngine();
  }

  @override
  void onTap() {
    bird.flap();
  }
}
