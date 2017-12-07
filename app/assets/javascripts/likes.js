$(document).ready(function () {

  $like_btn = $('.js-like-image');
  $like_label = $('.js-count-like-label');

  if (($like_btn.attr('data-liked')) == 1) {
    $like_btn.html('Unlike');
  }
  else {
    $like_btn.html('Like');
  }


  $like_btn.click(function () {

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
        $like_label.html(image.likes)
      },
      error: function (error) {
        alert('Error. Please try again ')
      }
    });


    (function ($) {
      $.fn.like = function (image) {
        $btn.addClass('btn-primary').val('Like');
        $btn.attr('method', 'post');
        $btn.attr('action', image.like_path);
        $btn.attr('data-liked', 0);
        $btn.html('Like');
        return this;
      };
    })(jQuery);

    (function ($) {
      $.fn.unlike = function (image) {
        $btn.removeClass('btn-primary').val('Unlike');
        $btn.attr('method', 'delete');
        $btn.attr('action', image.unlike_path);
        $btn.attr('data-liked', 1);
        $btn.html('Unlike');
        return this;
      };
    })(jQuery);

  });

});