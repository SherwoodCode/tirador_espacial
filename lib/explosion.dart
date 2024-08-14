import 'package:flame/components.dart';
import 'package:space_shooter/main.dart';

class Explosion extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  Explosion({
    super.position,
  }) : super(
            size: Vector2.all(150),
            anchor: Anchor.center,
            removeOnFinish: true);

  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'explosion 2.png',
      SpriteAnimationData.sequenced(
        amount: 62,
        stepTime: 0.1,
        textureSize: Vector2(256, 256),
        loop: false
      ),
    );
    return super.onLoad();
  }
}
