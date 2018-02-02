$(document).ready(function () {
  $.getScript('/gallery/app/assets/javascripts/robot/robot.js');
  $.getScript('/gallery/app/assets/javascripts/robot/interface.js');
  $.getScript('/gallery/app/assets/javascripts/robot/command.js');
  $.getScript('/gallery/app/assets/javascripts/robot/table.js');

  $info = $('#info');
  $command_text = $('#command_text');
  $command_button = $('#send_command_button');


  $info.html('Hello. Do you want to use 5x6 (press 1) or enter X and Y (press 2) ?');
  var mInterface = new Interface(5, 5);


  $command_button.on('click', function () {
    console.log('click');
   mInterface.read();
  });
});


