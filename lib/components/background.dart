import 'package:flame/components.dart';
import 'package:flappy_bird_flame/game_page.dart';

class Background extends SpriteComponent with HasGameRef<GamePage> {
  Background(Vector2 size) : super(size: size, position: Vector2.zero());

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load("ground.png");
  }
}
