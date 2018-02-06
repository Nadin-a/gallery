let myGameArea = {
  canvas: document.createElement("canvas"),
  start: function () {
    this.canvas.width = height * 100;
    this.canvas.height = width * 100;
    this.canvas.style = 'border:1px solid #000000;  ' +
      'background-image: url("https://thumbs.dreamstime.com/b/wooden-desk-' +
      'floor-table-background-brown-53254017.jpg");';
    this.context = this.canvas.getContext('2d');
    document.body.insertBefore(this.canvas, document.body.childNodes[0]);
  },
  clear: function () {
    this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
  }
};

function Robot_component(width, height, x, y) {
  this.width = width;
  this.height = height;
  this.x = x;
  this.y = y;


  this.update = function (dir) {
    ctx = myGameArea.context;
    let pic = new Image();

    switch (dir) {
      case 'NORTH': {
        pic.src = 'http://i.piccy.info/i9/08e85506d50eae32e3226699d8f1cf3c/1517837323/17756/1214116/2.png';
        break;
      }
      case 'EAST': {
        pic.src = 'http://i.piccy.info/i9/db77d6f15e9319fa6e48d1dcfb5850a3/1517837357/13621/1214116/4.png';
        break;
      }
      case 'SOUTH': {
        pic.src = 'http://i.piccy.info/i9/ce72c29599998027cd4da91ba4f35b9d/1517837091/17492/1214116/1.png';
        break;
      }
      case 'WEST': {
        pic.src = 'http://i.piccy.info/i9/2a4d520a201c1266ac803a6c7687ab6d/1517837337/13561/1214116/3.png';
        break;
      }
    }

    ctx.fillStyle = ctx.createPattern(pic, 'repeat');
    ctx.fillRect(this.x, this.y, this.width, this.height);
  }
}

const updateGameArea = (coord, dir) => {
  myGameArea.clear();
  mRobot.x = coord['x'] * 100;
  mRobot.y = coord['y'] * 100;
  mRobot.update(dir);
};
