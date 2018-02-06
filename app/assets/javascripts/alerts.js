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
$(document).ready(() => {
  const close_alert = () => {
    var obj = document.getElementById('alert');
    obj.style.display = "none";
  };
});
