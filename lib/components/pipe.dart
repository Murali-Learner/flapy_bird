import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_flame/constants.dart';
import 'package:flappy_bird_flame/game_page.dart';

class Pipe extends SpriteComponent
    with HasGameRef<GamePage>, CollisionCallbacks {
  final bool isTopPipe;
  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(
          position: position,
          size: size,
        );
  bool isScored = false;
  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? "pipe_bottom.png" : "pipe_top.png");
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= bottomScrollingSpeed * dt;
    if (!isScored && position.x + size.x < gameRef.bird.position.x) {
      isScored = true;
      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
