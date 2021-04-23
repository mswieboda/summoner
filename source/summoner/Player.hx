package summoner;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxColor;

class Player extends FlxSprite {
  static inline var MOVEMENT_SPEED = 100;
  static inline var DRAG: Int = 1000;
  static inline var WALK_FPS = 6;

  var direction: Int;

  public function new(x: Float, y: Float, color: FlxColor = FlxColor.WHITE) {
    super(x, y);

    this.color = color;

    direction = Direction.NORTH;

    loadGraphic(AssetPaths.player__png, true, 32, 32);

    // TODO; make a method to figure this out:
    // COLS = 4;
    // var row = Direction.toSpriteRow(Direction.North);
    // var n = row * COLS - row;
    // n, n + 2, n + 1, n + 2;
    animation.add("North", [0, 2, 1, 2], WALK_FPS, false);
    animation.add("Northeast", [3, 5, 4, 5], WALK_FPS, false);
    animation.add("East", [6, 8, 7, 8], WALK_FPS, false);
    animation.add("Southeast", [9, 11, 10, 11], WALK_FPS, false);
    animation.add("South", [12, 14, 13, 14], WALK_FPS, false);
    animation.add("Southwest", [15, 17, 16, 17], WALK_FPS, false);
    animation.add("West", [18, 20, 19, 20], WALK_FPS, false);
    animation.add("Northwest", [21, 23, 22, 23], WALK_FPS, false);

    drag.x = drag.y = DRAG;
  }

  override public function update(elapsed: Float) {
    super.update(elapsed);

    updateMovement();
  }

  function updateMovement() {
    var ups = [FlxKey.UP, FlxKey.W];
    var downs = [FlxKey.DOWN, FlxKey.S];
    var lefts = [FlxKey.LEFT, FlxKey.A];
    var rights = [FlxKey.RIGHT, FlxKey.D];
    var up = FlxG.keys.anyPressed(ups);
    var down = FlxG.keys.anyPressed(downs);
    var left = FlxG.keys.anyPressed(lefts);
    var right = FlxG.keys.anyPressed(rights);

    if (up && down) up = down = false;
    if (left && right) left = right = false;

    if (FlxG.keys.anyJustReleased(ups.concat(downs).concat(lefts).concat(rights))) {
      animation.pause();
    }

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
