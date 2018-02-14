class GameArea {

  constructor() {
    this.canvas = document.createElement('canvas');
  }

  start() {
    this.canvas.width = height * 100;
    this.canvas.height = width * 100;
    this.canvas.style = 'border:1px solid #000000;  ' +
      'background-image: url("https://thumbs.dreamstime.com/b/wooden-desk-' +
      'floor-table-background-brown-53254017.jpg");';
    this.context = this.canvas.getContext('2d');
    document.body.insertBefore(this.canvas, document.body.childNodes[0]);
  }

  clear() {
    this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
  }
}

const updateGameArea = (coord, dir) => {
  myGameArea.clear();
  mRobot.x = coord.x * 100;
  mRobot.y = coord.y * 100;
  mRobot.update(dir);
};
