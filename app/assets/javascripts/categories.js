$(document).ready(function () {

  $subscribe_btn = $('.js-subscribtion-category');

  if (($subscribe_btn.attr('data-subscribed')) == 1) {
    $subscribe_btn.html('Unsubscribe');
  }
  else {
    $subscribe_btn.html('Subscribe');
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
      },
      error: function (error) {
        alert('Error. Please try again')
      }
    });

    (function ($) {
      $.fn.subscribe = function (category) {
        $btn.addClass('btn-primary').val('Subscribe');
        $btn.attr('method', 'post');
        $btn.attr('action', category.subscribe_path);
        $btn.attr('data-subscribed', 0);
        $btn.html('Subscribe');
        return this;
      };
    })(jQuery);

    (function ($) {
      $.fn.unsubscribe = function (category) {
        $btn.removeClass('btn-primary').val('Unsubscribe');
        $btn.attr('method', 'delete');
        $btn.attr('action', category.unsubscribe_path);
        $btn.attr('data-subscribed', 1);
        $btn.html('Unsubscribe');
        return this;
      };
    })(jQuery);

  });

  

});