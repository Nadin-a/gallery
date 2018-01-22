App.image = App.cable.subscriptions.create('ImageChannel', {
  connected: function () {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function () {;
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    // Called when there's incoming data on the websocket for this channel
    $current_url = window.location.href;
    $url = '';
    if (data.url) {
      url = data.url
    }
    else {
      url = 'categories/' + data.category + '/images/' + data.image
    }
    if ($current_url.endsWith(url)) {
      $like_label.html(data.count);
      if (data.comment) {
        return $('#new_comments').append(this.renderComment(data.comment));
      }
    }
  },

  renderComment: function (comment) {
    return comment;
  },

  send_comment: function (comment) {
    return this.perform('send_comment', {
      comment: comment
    });
  }
});

$(document).on('keypress', '.new_comment', function (e) {
  var code = e.charCode || e.keyCode;
  if (code == 13 && !e.shiftKey) {
    e.preventDefault();
    var values = $(this).serializeArray();
    App.image.send_comment(values);
    $(this).trigger('reset');
  }
});

$(document).on('submit', '.new_comment', function (e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.image.send_comment(values);
  $(this).trigger('reset');

});

