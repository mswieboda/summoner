package summoner;

// TODO: convert this to a real class/type instead of using Int externally
class Direction {
  public static inline var NONE = 0;
  public static inline var NORTH = 1;
  public static inline var NORTHWEST = 2;
  public static inline var WEST = 3;
  public static inline var SOUTHWEST = 4;
  public static inline var SOUTH = 5;
  public static inline var SOUTHEAST = 6;
  public static inline var EAST = 7;
  public static inline var NORTHEAST = 8;

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
          case WEST:
            return NORTHWEST;
          case EAST:
            return NORTHEAST;
          default:
            throw new haxe.Exception('can\'t combine $direction and $other');
        }
      case SOUTH:
        switch(other) {
          case WEST:
            return SOUTHWEST;
          case EAST:
            return SOUTHEAST;
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
      case NORTHWEST:
        return "Northwest";
      case WEST:
        return "West";
      case SOUTHWEST:
        return "Southwest";
      case SOUTH:
        return "South";
      case SOUTHEAST:
        return "Southeast";
      case EAST:
        return "East";
      case NORTHEAST:
        return "Northeast";
      default:
        return "_InvalidDirection_";
    }
  }
}
