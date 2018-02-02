class Table {

  constructor(height, width) {
    this.height = height;
    this.width = width;
  }

  check_borders(coord) {
    console.log('table check_borders');
    if (coord['x'] < this.height && coord['y'] < this.width && coord['x'] >= 0 && coord['y'] >= 0) {
      return true;
    }
  }

}