import 'package:flame/components.dart';
import 'package:space_shooter/bullet.dart';
import 'package:space_shooter/main.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  Player()
      : super(
          size: Vector2(120, 170),
          anchor: Anchor.center,
        );
  late final SpawnComponent _bulletSpawner;

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'Nairan - Fighter - Weapons.png',
      SpriteAnimationData.sequenced(
        amount: 28,
        stepTime: 0.2,
        textureSize: Vector2(64, 64),
      ),
    );
    position = game.size / 2;

    _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position +
              Vector2(
                0,
                -height / 2,
              ),
        );
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);

    return super.onLoad();
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void startSooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }
}
