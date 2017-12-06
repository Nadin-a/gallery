$(document).ready(function () {

  $subscribe_btn = $('.js-like-image');

  if (($subscribe_btn.attr('data-liked')) == 1) {
    $subscribe_btn.html('Remove like');
  }
  else {
    $subscribe_btn.html('Like');
  }


  $subscribe_btn.click(function () {

    let $btn = $(this);
    let flag = $btn.attr('data-liked');

    $.ajax({
      dataType: 'JSON',
      method: $btn.attr('method'),
      url: $btn.attr('action'),
      success: function (image) {
        if (flag == 1) {
          $btn.like(image);
        }
        else {
          $btn.unlike(image);
        }
      },
      error: function (error) {
        alert('Error. Please try again')
      }
    });


  });

  (function ($) {
    $.fn.like = function (image) {
      $btn.addClass('btn-primary').val('Like');
      $btn.attr('method', 'post');
      $btn.attr('action', image.subscribe_path);
      $btn.attr('data-subscribed', 0);
      $btn.html('Subscribe');
      return this;
    };
  })(jQuery);

  (function ($) {
    $.fn.unlike = function (image) {
      $btn.removeClass('btn-primary').val('Remove like');
      $btn.attr('method', 'delete');
      $btn.attr('action', image.unsubscribe_path);
      $btn.attr('data-subscribed', 1);
      $btn.html('Unsubscribe');
      return this;
    };
  })(jQuery);



});