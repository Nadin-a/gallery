class Interface {
  constructor(x, y, properties) {
    this.robot = new Robot(properties);
    this.table = new Table(x, y);
  }

  read(command) {
    this.command = command;
    if (this.robot && this.table) {
      this.execute();
    } else {
      this.read(command);
    }
  }

  execute() {
    $info.html(`Execution command: ${this.command}`);
    switch (this.command) {
      case 'MOVE': {
        this.step();
        break;
      }
      case 'REPORT': {
        this.robot.report();
        break;
      }
      case 'RIGHT': {
        this.robot.changeDirection(this.command);
        break;
      }
      case 'LEFT': {
        this.robot.changeDirection(this.command);
        break;
      }
      default: {
        break;
      }
    }
  }

  step() {
    if (this.table.checkBorders(this.robot.checkNextPosition())) {
      this.robot.move();
    }
  }
}
