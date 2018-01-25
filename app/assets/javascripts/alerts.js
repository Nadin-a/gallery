$(document).ready(function () {

  $("#couner_of_notification").html('🔔');

  $('.alert').fadeIn('slow', function () {
    $('.alert').delay(5000).fadeOut();
  });

  $('.close').on('click', function () {
    $('.alert').hide();
  });


});


function show_notification() {
  // Get the snackbar DIV
  let x = document.getElementById('snackbar');

  // Add the "show" class to DIV
  x.className = 'show';

  // After 3 seconds, remove the show class from DIV
  setTimeout(function(){  x.className =  x.className.replace('show', ''); }, 3000);
  $(".new_notification").html('');
}
