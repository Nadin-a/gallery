class Command {

  constructor(args) {
    this.name = args; //first
    this.args = args;
  }

  validate(robot, table) {
    switch (this.name) {
      case 'PLACE': {
        return this.validate_place(robot, table);
      }
      // case 'MOVE', 'REPORT', 'LEFT', 'RIGHT', 'HELP', 'EXIT': {
      //   return robot && table ? true : false;
      // }
      default: {
        return robot && table ? true : false;
        // console.log('Uncorrect command');
        // return false;
      }
    }
  }

  validate_place(robot, table) {
    if (!robot && table) {
      var errors = '';

      if (this.args.length == 4) {
        if (!(this.args[1].match(/[0-9]+/) || this.args[2].match(/[0-9]+/))) {
          errors += 'X and/or Y must be numbers. '
        }
      }
      else {
        errors += 'Uncorrect format of command. Try (PLACE X Y DIRECTION).  '
      }

      if (!Robot.SIDES.includes(this.args.last)) {
        errors += 'Direction must be NORTH or EAST or SOUTH or WEST. ';
      }

      if (errors === "") {
        return true;
      }
      else {
        console.log(errors);
        return false
      }
    }
    else {
      console.log('Robot on the table yet');
    }
  }

}
