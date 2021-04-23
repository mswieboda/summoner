package summoner;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite {
  public function new(x: Float, y: Float, color: FlxColor) {
    super(x, y);

    this.color = color;

    makeGraphic(32, 32, color);
  }
}
