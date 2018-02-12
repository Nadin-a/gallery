document.addEventListener('DOMContentLoaded', () => {
  $subscribeBtn = $('.js-subscribtion-category');
  $followersLabel = $('#js-count-followers-label');

  if (($subscribeBtn.attr('data-subscribed')) === 1) {
    $subscribeBtn.html('<span class="glyphicon glyphicon-bell"></span>');
  } else {
    $subscribeBtn.html('<span class="glyphicon glyphicon-bell"></span>');
  }

  $subscribeBtn.click(function () {
    const $btn = $(this);
    const flag = $btn.attr('data-subscribed');

    const subscribe = (category) => {
      $btn.removeClass('btn btn-default').addClass('btn btn-success').val('Subscribe');
      $btn.attr('data-method', 'post');
      $btn.attr('data-action', category.subscribe_path);
      $btn.attr('data-subscribed', 0);
      $btn.html('<span class="glyphicon glyphicon-bell"></span>'); // subscribe
    };

    const unsubscribe = (category) => {
      $btn.removeClass('btn btn-success').addClass('btn btn-default').val('Unsubscribe');
      $btn.attr('data-method', 'delete');
      $btn.attr('data-action', category.unsubscribe_path);
      $btn.attr('data-subscribed', 1);
      $btn.html('<span class="glyphicon glyphicon-bell"></span>'); // unsubscribe
      return this;
    };

    $.ajax({
      dataType: 'JSON',
      method: $btn.attr('data-method'),
      url: $btn.attr('data-action'),
      success(category) {
        if (flag === '1') {
          subscribe(category);
        } else {
          unsubscribe(category);
        }
        $followersLabel.html(category.followers);
      },
    });
  });
});
