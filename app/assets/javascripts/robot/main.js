let height = '';
let width = '';
let properties;
let mInterface;
$(document).ready(() => {
  let gameStart = false;
  let showHelp = true;

  $info = $('#info');
  $height = $('#height');
  $width = $('#width');
  $sendSizesButton = $('#send_sizes_button');
  $actionBtn = $('.command');
  $sides = $('#sides');
  $reloadBtn = $('#reload_button');
  $helpButton = $('#help_button');
  $alert = $('.robot_rules');
  $info.html('Enter sizes of field');

  $actionBtn.hide();
  $sides.hide();
  $alert.hide();

  $sendSizesButton.on('click', () => {
    if (height === '' && width === '') {
      height = $height.val();
      width = $width.val();
      $height.attr({
        max: height,
        value: 1,
      });
      $width.attr({
        max: width,
        value: 1,
      });
      $info.html('Place the robot!');
      $sides.show();
    } else {
      const robotX = parseInt($height.val(), 10);
      const robotY = parseInt($width.val(), 10);
      const side = $sides.val();

      $height.hide();
      $width.hide();
      $sendSizesButton.hide();
      $sides.hide();

      $actionBtn.show();
      $info.html('');

      properties = { x: robotX - 1, y: robotY - 1, dir: side };
      mInterface = new Interface(height, width, properties);
      gameStart = true;
      myGameArea.start();
      mRobot = new Robot_component(100, 100, robotX, robotY);
      updateGameArea({ x: robotX - 1, y: robotY - 1 }, side);
    }
  });

  $reloadBtn.on('click', () => {
    location.reload();
  });

  $helpButton.on('click', () => {
    if (showHelp) {
      $alert.show();
    } else {
      $alert.hide();
    }
    showHelp = !showHelp;
  });


  $actionBtn.bind('click', function () {
    mInterface.read(this.value);
  });

  $(document).keypress((e) => {
    if (gameStart) {
      const keycode = (e.keyCode ? e.keyCode : e.which);
      if (keycode === 37) {
        mInterface.read('LEFT');
      }
      if (keycode === 39) {
        mInterface.read('RIGHT');
      }
      if (keycode === 32) {
        mInterface.read('MOVE');
      }
      if (keycode === 13) {
        mInterface.read('REPORT');
      }
    }
  });
});
