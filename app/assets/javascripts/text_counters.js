$(document).ready(function () {

  $text_area = $('.limited-text-input');

  if ($text_area.is(':visible')) {
    let text_max = 200;
    $('#count_message').html($text_area.val().length + '/' + text_max);
    $text_area.keyup(function () {
      let text_length = $text_area.val().length;
      $('#count_message').html(text_length + '/' + text_max);
    });
  }
});