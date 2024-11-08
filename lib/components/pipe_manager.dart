import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird_flame/components/pipe.dart';
import 'package:flappy_bird_flame/constants.dart';
import 'package:flappy_bird_flame/game_page.dart';

class PipeManager extends Component with HasGameRef<GamePage> {
  double pipeSpawnTimer = 0;
  @override
  FutureOr<void> onLoad() {
    spawnPipe();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    pipeSpawnTimer += dt;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;

    final maxPipeHeight = screenHeight - bottomHeight - pipeGap - minPipeHeight;

    final bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    final topPipeHeight =
        screenHeight - bottomHeight - bottomPipeHeight - pipeGap;

    final bottomPipe = Pipe(
      Vector2(gameRef.size.x, screenHeight - bottomHeight - bottomPipeHeight),
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    final topPipe = Pipe(
      Vector2(gameRef.size.x, 0),
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
