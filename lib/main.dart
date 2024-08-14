import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:space_shooter/enemy.dart';
import 'package:space_shooter/player.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Player player;

  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/parallax-space-stars.png'),
        ParallaxImageData('parallax/parallax-space-backgound.png'),
        ParallaxImageData('parallax/parallax-space-big-planet.png'),
        ParallaxImageData('parallax/parallax-space-far-planets.png'),
        ParallaxImageData('parallax/parallax-space-ring-planet.png'),
      ],
      baseVelocity: Vector2(0, -3),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 2),
    );
    add(parallax);
    player = Player();
    await add(player);

    add(
      SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 1,
        area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
      ),
    );
    return super.onLoad();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startSooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }
}

void main() {
  runApp(GameWidget(game: SpaceShooterGame()));
}
