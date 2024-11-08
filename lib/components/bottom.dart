import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_flame/constants.dart';
import 'package:flappy_bird_flame/game_page.dart';

class Bottom extends SpriteComponent
    with HasGameRef<GamePage>, CollisionCallbacks {
  Bottom() : super();

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(2 * gameRef.size.x, bottomHeight);
    position = Vector2(0, gameRef.size.y - bottomHeight);

    sprite = await Sprite.load("bottom.png");
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= bottomScrollingSpeed * dt;
    // debugPrint("bottom update dt $dt");
    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
