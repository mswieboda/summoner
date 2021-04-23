package summoner;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite {
  static inline var MOVEMENT_SPEED = 100;
  static inline var DRAG: Int = 1000;

  public function new(x: Float, y: Float, color: FlxColor = FlxColor.WHITE) {
    super(x, y);

    this.color = color;

    loadGraphic(AssetPaths.player__png, false, 32, 32);

    drag.x = drag.y = DRAG;
  }

  override public function update(elapsed: Float) {
    super.update(elapsed);

    updateMovement();
  }

  function updateMovement() {
    var up = FlxG.keys.anyPressed([UP, W]);
    var down = FlxG.keys.anyPressed([DOWN, S]);
    var left = FlxG.keys.anyPressed([LEFT, A]);
    var right = FlxG.keys.anyPressed([RIGHT, D]);

    var vx = velocity.x;
    var vy = velocity.y;

    if (up && down) up = down = false;
    if (left && right) left = right = false;

    if (up || down) {
      vy = up ? -MOVEMENT_SPEED : MOVEMENT_SPEED;
    }

    if (left || right) {
      vx = left ? -MOVEMENT_SPEED : MOVEMENT_SPEED;
    }

    if (up || down || left || right) {
      var distance = Math.sqrt(Math.pow(vx, 2) + Math.pow(vy, 2));

      vx = vx / distance * MOVEMENT_SPEED;
      vy = vy / distance * MOVEMENT_SPEED;

      velocity.set(vx, vy);
    }
  }
}
