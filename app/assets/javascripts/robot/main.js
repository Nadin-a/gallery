let height = '', width = '';
let properties;
let mInterface;
$(document).ready(function () {

  let gameStart = false;
  let show_help = true;

  $info = $('#info');
  $height = $('#height');
  $width = $('#width');
  $send_sizes_button = $('#send_sizes_button');
  $action_btn = $('.command');
  $sides = $('#sides');
  $reload_btn = $('#reload_button');
  $help_button = $('#help_button');
  $alert = $('.alert');
  $info.html('Enter sizes of field');

  $action_btn.hide();
  $sides.hide();
  $alert.hide();

  $send_sizes_button.on('click', function () {
    if (height === '' && width === '') {
      height = $height.val();
      width = $width.val();
      $height.attr({
        'max': height,
        'value': 1
      });
      $width.attr({
        'max': width,
        'value': 1
      });
      $info.html('Place the robot!');
      $sides.show();
    }
    else {
      let robot_x = parseInt($height.val());
      let robot_y = parseInt($width.val());
      let side = $sides.val();

      $height.hide();
      $width.hide();
      $send_sizes_button.hide();
      $sides.hide();

      $action_btn.show();
      $info.html('');

      properties = {x: robot_x - 1, y: robot_y - 1, dir: side};
      mInterface = new Interface(height, width, properties);
      gameStart = true;
      myGameArea.start();
      mRobot = new Robot_component(100, 100, robot_x, robot_y);
      updateGameArea({x: robot_x - 1, y: robot_y - 1}, side);

    }
  });

  $reload_btn.on('click', function () {
    location.reload();
  });

  $help_button.on('click', function () {
    if(show_help) {
      $alert.show();
    }
    else {
      $alert.hide();
    }
    show_help =! show_help;
  });


  $action_btn.bind('click', function () {
    mInterface.read(this.value);
  });

  $(document).keypress(function(e) {
    if(gameStart) {
      let keycode = (e.keyCode ? e.keyCode : e.which);
      if (keycode == '37') {
        mInterface.read('LEFT');
      }
      if (keycode == '39') {
        mInterface.read('RIGHT');
      }
      if (keycode == '32') {
        mInterface.read('MOVE');
      }
      if (keycode == '13') {
        mInterface.read('REPORT');
      }
    }
  });

});
