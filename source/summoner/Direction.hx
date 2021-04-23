package summoner;

// TODO: convert this to a real class/type instead of using Int externally
class Direction {
  public static inline var NONE = 0;
  public static inline var NORTH = 1;
  public static inline var NORTHEAST = 2;
  public static inline var EAST = 3;
  public static inline var SOUTHEAST = 4;
  public static inline var SOUTH = 5;
  public static inline var SOUTHWEST = 6;
  public static inline var WEST = 7;
  public static inline var NORTHWEST = 8;

  var direction: Int;

  public static function opposite(direction: Int) {
    // TODO: impl
    return NONE;
  }

  public static function combine(direction: Int, other: Int) {
    if (direction == NONE) return other;
    if (direction == NONE) return direction;

    switch(direction) {
      case NORTH:
        switch(other) {
          case EAST:
            return NORTHEAST;
          case WEST:
            return NORTHWEST;
          default:
            throw new haxe.Exception('can\'t combine $direction and $other');
        }
      case SOUTH:
        switch(other) {
          case EAST:
            return SOUTHEAST;
          case WEST:
            return SOUTHWEST;
          default:
            throw new haxe.Exception('can\'t combine $direction and $other');
        }
      case WEST:
        return combine(other, direction);
      case EAST:
        return combine(other, direction);
      default:
        throw new haxe.Exception('can\'t combine $direction and $other');
    }
  }

  public static function toString(direction: Int): String {
    switch(direction) {
      case NONE:
        return "None";
      case NORTH:
        return "North";
      case NORTHEAST:
        return "Northeast";
      case EAST:
        return "East";
      case SOUTHEAST:
        return "Southeast";
      case SOUTH:
        return "South";
      case SOUTHWEST:
        return "Southwest";
      case WEST:
        return "West";
      case NORTHWEST:
        return "Northwest";
      default:
        return "_InvalidDirection_";
    }
  }
}
