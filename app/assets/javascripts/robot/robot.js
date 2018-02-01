class Robot {

  static get SIDES() {
    return ['NORTH', 'EAST', 'SOUTH', 'WEST'];
  }

  constructor(properties) {
    this.coord = {x: properties['x'], y: properties['y']};
    this.direction = properties['dir'];
  }

  change_direction(rotation) {
    var previous_value = Robot.SIDES[Robot.SIDES.index(this.direction) - 1];
    var next_value = Robot.SIDES[Robot.SIDES.index(this.direction) + 1];
    switch (rotation) {
      case 'LEFT': {
        this.direction = previous_value;
        break;
      }
      case 'RIGHT': {
        this.direction = next_value == null ? Robot.SIDES[0] : next_value;
        break;
      }
    }
  }

  move() {
    this.coord = this.check_next_position();
  }

  check_next_position() {
    console.log('check_next_position');
    var next_x = this.coord['x'];
    var next_y = this.coord['y'];

    switch (this.direction) {
      case 'NORTH': {
        next_y += 1;
        break;
      }
      case 'EAST': {
        next_x += 1;
        break;
      }
      case 'SOUTH': {
        next_y -= 1;
        break;
      }
      case 'WEST': {
        next_x -= 1;
        break;
      }
    }
    return {x: next_x, y: next_y};
  }

  report() {
    console.log(this.coord['x'] + ':' + this.coord['y'] + ' ' + this.direction);
  }

}