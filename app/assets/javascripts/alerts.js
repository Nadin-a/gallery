$(document).ready(function () {
  $('.alert').fadeIn('slow', function () {
    $('.alert').delay(5000).fadeOut();
  });

  $('.close').on('click', function () {
    $('.alert').hide();
  });

});
