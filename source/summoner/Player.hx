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

    loadGraphic(AssetPaths.player__png, true, 32, 32);

    animation.add("North", [0], 12, false);
    animation.add("Northeast", [1], 12, false);
    animation.add("East", [2], 12, false);
    animation.add("Southeast", [3], 12, false);
    animation.add("South", [4], 12, false);
    animation.add("Southwest", [5], 12, false);
    animation.add("West", [6], 12, false);
    animation.add("Northwest", [7], 12, false);

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
    animation.play(Direction.toString(direction));

    var distance = Math.sqrt(Math.pow(vx, 2) + Math.pow(vy, 2));

    vx = vx / distance * MOVEMENT_SPEED;
    vy = vy / distance * MOVEMENT_SPEED;

    velocity.set(vx, vy);
  }
}
