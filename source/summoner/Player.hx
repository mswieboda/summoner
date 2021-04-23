package summoner;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite {
  static inline var MOVEMENT_SPEED = 100;
  static inline var DRAG: Int = 1000;

  var direction: Int;

  public function new(x: Float, y: Float, color: FlxColor = FlxColor.WHITE) {
    super(x, y);

    this.color = color;

    direction = Direction.NORTH;

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

    if (up && down) up = down = false;
    if (left && right) left = right = false;
    if (!(up || down || left || right)) return;

    var direction = Direction.NONE;
    var vx = velocity.x;
    var vy = velocity.y;

    if (up) {
      vy = -MOVEMENT_SPEED;
      direction = Direction.NORTH;
    } else if (down) {
      vy = MOVEMENT_SPEED;
      direction = Direction.SOUTH;
    }

    if (left) {
      vx = -MOVEMENT_SPEED;
      direction = Direction.combine(direction, Direction.WEST);
    } else if (right) {
      vx = MOVEMENT_SPEED;
      direction = Direction.combine(direction, Direction.EAST);
    }

    this.direction = direction;

    var distance = Math.sqrt(Math.pow(vx, 2) + Math.pow(vy, 2));

    vx = vx / distance * MOVEMENT_SPEED;
    vy = vy / distance * MOVEMENT_SPEED;

    velocity.set(vx, vy);
  }
}
