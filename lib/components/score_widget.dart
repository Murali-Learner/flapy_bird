import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_bird_flame/game_page.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends TextComponent with HasGameRef<GamePage> {
  ScoreWidget()
      : super(
          text: 'Score: 0',
          textRenderer: TextPaint(
            style: const TextStyle(color: Colors.red, fontSize: 45),
          ),
        );

  @override
  FutureOr<void> onLoad() {
    position = Vector2(
      (gameRef.size.x - size.x) / 2,
      gameRef.size.y - size.y - 50,
    );
  }

  @override
  void update(double dt) {
    // Update the text to display the latest score from gameRef
    final newText = "Score: ${gameRef.score}";

    if (text != newText) {
      text = newText;
    }
  }
}
