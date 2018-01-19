$(document).ready(function () {
  $show_all_btn = $('.btn-show-all-comments');
  $show_all_label = $('#show_all_label');

  $show_all_btn.click(function () {

  $.ajax({
      dataType: 'JSON',
    method: 'get',
      success: function (data) {
        $('#hidden_comments').append(data.hidden_comments);
        $show_all_btn.hide();
      },
      error: function (error) {
        console.log('error');
        console.log(error);
      }
    });
  });
});
