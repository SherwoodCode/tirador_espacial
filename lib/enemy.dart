import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_shooter/bullet.dart';
import 'package:space_shooter/explosion.dart';
import 'package:space_shooter/main.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  Enemy({
    super.position,
  }) : super(
          size: Vector2.all(enemySize),
          anchor: Anchor.center,
        );
  static const enemySize = 50.0;

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'Attack_KG_2.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.2,
        textureSize: Vector2(100, 64),
      ),
    );
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += dt * 250;
    if (position.y > game.size.y) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
      game.add(Explosion(position: position));
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
