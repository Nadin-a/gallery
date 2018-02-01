App.image = App.cable.subscriptions.create('ImageChannel', {
  connected: () =>  {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () =>  {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    if ($("#new_comments").attr('data-image-id') == data.image) {
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

