App.image = App.cable.subscriptions.create('ImageChannel', {
  connected: () => {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    // Called when there's incoming data on the websocket for this channel
    let newComment = document.getElementById('new_comments');
    let like_label = document.getElementById('js-count-like-label');
    if (newComment.getAttribute('data-image-id') == data.image) {
      like_label.innerHTML = data.count;
      if (data.comment) {
        let content = document.createElement('div');
        content.innerHTML = this.renderComment(data.comment);
        return newComment.appendChild(content);
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

const pressKeySendComment = (event) => {
  let code = event.charCode || event.keyCode;
  if (code === 13 && !event.shiftKey) {
    event.preventDefault();
    send_comment_form();
  }
};

const pressBtnSendComment = () => {
  send_comment_form();
};

const send_comment_form = () => {
  let formComment = document.getElementById('comment_input');
  let values = $(formComment).serializeArray();
  App.image.send_comment(values);
  formComment.reset();
};