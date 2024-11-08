import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_flame/components/bottom.dart';
import 'package:flappy_bird_flame/components/pipe.dart';
import 'package:flappy_bird_flame/constants.dart';
import 'package:flappy_bird_flame/game_page.dart';
import 'package:flutter/material.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  Bird()
      : super(
            position: Vector2(birdStartX, birdStartY),
            size: Vector2(birdWidth, birdHeight));

  double velocity = 0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("bird.png");
    add(RectangleHitbox());
  }

  void flap() {
    // FlameAudio.play('wing.wav');
    debugPrint("velo $velocity jump $jumpStrength");
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    velocity += gravity * dt;
    position.y += velocity * dt;

    if (position.y <= 0) {
      (parent as GamePage).gameOver();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Bottom) {
      (parent as GamePage).gameOver();
    }

    if (other is Pipe) {
      (parent as GamePage).gameOver();
    }
  }
}
