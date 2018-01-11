$(document).ready(function () {

  $like_btn = $('.js-like-image');
  $like_label = $('.js-count-like-label');

  if (($like_btn.attr('data-liked')) == 1) {
    heart();
  }
  else {
    heart_empty();
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
        $like_label.html(image.likes);
      },
      error: function (error) {
        alert('Error. Please try again ')
      }
    });

    (function ($) {
      $.fn.like = function (image) {
        $btn.addClass('btn-success').val('Like');
        $btn.attr('method', 'post');
        $btn.attr('action', image.like_path);
        $btn.attr('data-liked', 0);
        heart_empty();

        return this;
      };
    })(jQuery);

    (function ($) {
      $.fn.unlike = function (image) {
        $btn.removeClass('btn-success').addClass('btn-default').val('Unlike');
        $btn.attr('method', 'delete');
        $btn.attr('action', image.unlike_path);
        $btn.attr('data-liked', 1);
        heart();
        return this;
      };
    })(jQuery);

  });

  function heart() {
    $like_btn.html('<span class="glyphicon glyphicon-heart"></span>');
    $like_btn.hover(function () {
      $(this).html('<span class="glyphicon glyphicon-heart-empty"></span>');
    }, function () {
      $(this).html('<span class="glyphicon glyphicon-heart"></span>');
    });
  }

  function heart_empty() {
    $like_btn.html('<span class="glyphicon glyphicon-heart-empty"></span>');
    $like_btn.hover(function () {
      $(this).html('<span class="glyphicon glyphicon-heart"></span>');
    }, function () {
      $(this).html('<span class="glyphicon glyphicon-heart-empty"></span>');
    });
  }

});