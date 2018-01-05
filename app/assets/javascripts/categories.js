$(document).ready(function () {

  $subscribe_btn = $('.js-subscribtion-category');
  $followers_label = $('.js-count-followers-label');

  if (($subscribe_btn.attr('data-subscribed')) == 1) {
    $subscribe_btn.html('<span class="glyphicon glyphicon-bell"></span>');
  }
  else {
    $subscribe_btn.html('<span class="glyphicon glyphicon-bell"></span>');
  }

  $subscribe_btn.click(function () {

    let $btn = $(this);
    let flag = $btn.attr('data-subscribed');

    $.ajax({
      dataType: 'JSON',
      method: $btn.attr('method'),
      url: $btn.attr('action'),
      success: function (category) {
        if (flag == 1) {
          $btn.subscribe(category);
        }
        else {
          $btn.unsubscribe(category);
        }
        $followers_label.html(category.followers)
      },
      error: function (error) {
        alert('Error. Please try again')
      }
    });

    (function ($) {
      $.fn.subscribe = function (category) {
        $btn.addClass('btn-success').val('Subscribe');
        $btn.attr('method', 'post');
        $btn.attr('action', category.subscribe_path);
        $btn.attr('data-subscribed', 0);
        $btn.html('<span class="glyphicon glyphicon-bell"></span>'); //subscribe
        return this;
      };
    })(jQuery);

    (function ($) {
      $.fn.unsubscribe = function (category) {
        $btn.removeClass('btn-success').val('Unsubscribe');
        $btn.attr('method', 'delete');
        $btn.attr('action', category.unsubscribe_path);
        $btn.attr('data-subscribed', 1);
        $btn.html('<span class="glyphicon glyphicon-bell"></span>'); //unsubscribe
        return this;
      };
    })(jQuery);

  });
});