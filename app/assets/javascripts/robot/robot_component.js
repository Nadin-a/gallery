class RobotComponent {

  constructor(width, height, x, y) {
    this.width = width;
    this.height = height;
    this.x = x;
    this.y = y;
  }


  update(dir) {
    let ctx = myGameArea.context;
    const pic = new Image();

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
  };
}