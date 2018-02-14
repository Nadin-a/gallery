class Robot {
  static get SIDES() {
    return ['NORTH', 'EAST', 'SOUTH', 'WEST'];
  }

  constructor(properties) {
    this.coord = { x: properties.x, y: properties.y };
    this.direction = properties.dir;
  }

  changeDirection(rotation) {
    let previousValue = Robot.SIDES[Robot.SIDES.indexOf(this.direction) - 1];
    if ((Robot.SIDES.indexOf(this.direction) - 1) < 0) {
      previousValue = 'WEST';
    }

    const nextValue = Robot.SIDES[Robot.SIDES.indexOf(this.direction) + 1];
    switch (rotation) {
      case 'LEFT': {
        this.direction = previousValue;
        break;
      }
      case 'RIGHT': {
        this.direction = nextValue === undefined ? Robot.SIDES[0] : nextValue;
        break;
      }
      default: {
        break;
      }
    }
    updateGameArea(this.coord, this.direction);
  }

  move() {
    updateGameArea(this.checkNextPosition(), this.direction);
    this.coord = this.checkNextPosition();
  }

  checkNextPosition() {
    let nextX = this.coord.x;
    let nextY = this.coord.y;

    switch (this.direction) {
      case 'NORTH': {
        nextY -= 1;
        break;
      }
      case 'EAST': {
        nextX += 1;
        break;
      }
      case 'SOUTH': {
        nextY += 1;
        break;
      }
      case 'WEST': {
        nextX -= 1;
        break;
      }
      default: {
        break;
      }
    }
    return { x: nextX, y: nextY };
  }

  report() {
    $info.html(`${this.coord.x}:${this.coord.y} ${this.direction}`);
  }
}
