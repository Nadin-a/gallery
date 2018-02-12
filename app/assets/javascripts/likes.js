document.addEventListener('DOMContentLoaded', () => {
  $likeBtn = $('.js-like-image');
  $likeLabel = $('#js-count-like-label');

  const showLikeIcon = () => {
    $likeBtn.html('<span class="glyphicon glyphicon-heart"></span>');
    $likeBtn.hover(function () {
      $(this).html('<span class="glyphicon glyphicon-heart-empty"></span>');
    }, function () {
      $(this).html('<span class="glyphicon glyphicon-heart"></span>');
    });
  };

  const showDislikeIcon = () => {
    $likeBtn.html('<span class="glyphicon glyphicon-heart-empty"></span>');
    $likeBtn.hover(function () {
      $(this).html('<span class="glyphicon glyphicon-heart"></span>');
    }, function () {
      $(this).html('<span class="glyphicon glyphicon-heart-empty"></span>');
    });
  };

  if (($likeBtn.attr('data-liked')) === 1) {
    showLikeIcon();
  } else {
    showDislikeIcon();
  }

  $likeBtn.click(function () {
    const $btn = $(this);
    const flag = $btn.attr('data-liked');

    const like = (image) => {
      $btn.addClass('btn-success').val('Like');
      $btn.attr('method', 'post');
      $btn.attr('action', image.like_path);
      $btn.attr('data-liked', 0);
      showDislikeIcon();
    };

    const dislike = (image) => {
      $btn.removeClass('btn-success').addClass('btn-default').val('Unlike');
      $btn.attr('method', 'delete');
      $btn.attr('action', image.unlike_path);
      $btn.attr('data-liked', 1);
      showLikeIcon();
    };

    $.ajax({
      dataType: 'JSON',
      method: $btn.attr('method'),
      url: $btn.attr('action'),
      success(image) {
        if (flag === '1') {
          like(image);
        } else {
          dislike(image);
        }
        $likeLabel.html(image.likes);
      },
    });
  });
});
