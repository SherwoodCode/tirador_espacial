import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shooter/main.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame> {
  Bullet({super.position})
      : super(
          size: Vector2(25, 50),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'arm/Nairan - Bolt.png',
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.3,
        textureSize: Vector2(9, 9),
      ),
    );

    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += dt * -500;
    if (position.y < -height) {
      removeFromParent();
    }
    super.update(dt);
  }
}
