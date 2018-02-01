class Interface {

  constructor(x, y) {
    this.robot = new Robot({x: 0, y: 0, dir: 'NORTH'}); //make null
    this.table = new Table(x, y);
    // this.read();
  }

  read() {
    console.log('Enter your command');
    console.log('Help: ' + (this.robot == null ? 'Place the robot! (PLACE X Y DIRECTION)' : 'Move robot! MOVE/REPORT/RIGHT/LEFT'));
    this.command = new Command($command_text); // get data

    if (this.command.validate(this.robot != null, this.table != null)) {
      this.execute();
    }
    else {
      this.read();
    }
  }


  execute() {
    console.log('Execution command: ' + this.command.name);
    switch (this.command.name) {
      case 'PLACE': {
        if (this.robot == null) {
          information = {x: this.command.args[1], y: this.args[2].to_i, dir: this.command.args[3]};
          this.place_robot(information);
        }
        break;
      }
      case 'MOVE': {
        this.step();
        break;
      }
      case 'REPORT': {
        this.robot.report();
        break;
      }
      case 'RIGHT': {
        this.robot.change_direction(this.command.name);
        break;
      }
      case 'LEFT': {
        this.robot.change_direction(this.command.name);
        break;
      }
      case 'HELP': {
        console.log('try MOVE/REPORT/RIGHT/LEFT');
        break;
      }
      case 'EXIT': {
        //exit
      }

    }
    this.read();
  }

  step() {
    if (this.table.check_borders(this.robot.check_next_position())) {
      this.robot.move();
    }
    else {
      console.log('BORDER');
    }
  }


  place_robot(position) {
    if (this.table.check_borders(position)) {
      this.robot = new Robot(position);
      console.log('Robot on table!');
    }
    else {
      console.log('Robot in`t on the table');
    }
  }

}