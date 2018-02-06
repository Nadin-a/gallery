class Interface {

  constructor(x, y, properties) {
    this.robot = new Robot(properties);
    this.table = new Table(x, y);
  }

  read(command) {
    this.command = command;
    if (this.robot && this.table) {
      this.execute();
    }
    else {
      this.read(command);
    }
  }

  execute() {
    $info.html('Execution command: ' + this.command);
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
        this.robot.change_direction(this.command);
        break;
      }
      case 'LEFT': {
        this.robot.change_direction(this.command);
        break;
      }
    }
  }

  step() {
    if (this.table.check_borders(this.robot.check_next_position())) {
      this.robot.move();
    }
  }
}