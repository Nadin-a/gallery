const close_alert = () => {
  var obj = document.getElementById('alert');
  obj.style.display = "none";
};

setTimeout(() => {
  close_alert();
}, 5000);

// $(document).ready(function () {
//   $('.alert').fadeIn('slow', function () {
//     $('.alert').delay(5000).fadeOut();
//   });
//
//   $('.close').on('click', function () {
//     $('.alert').hide();
//   });
//
// });
