App.image = App.cable.subscriptions.create('ImageChannel', {
  connected: () => {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const newComment = document.getElementById('new_comments');
    const likeLabel = document.getElementById('js-count-like-label');
    if (newComment.getAttribute('data-image-id') == data.image) {
      likeLabel.innerHTML = data.count;
      if (data.comment) {
        const content = document.createElement('div');
        content.innerHTML = this.renderComment(data.comment);
        return newComment.appendChild(content);
      }
    }
    return true;
  },

  renderComment(comment) {
    return comment;
  },

  send_comment(comment) {
    return this.perform('send_comment', {
      comment,
    });
  },
});

const send_comment_form = () => {
  const formComment = document.getElementById('comment_input');
  const values = $(formComment).serializeArray();
  App.image.send_comment(values);
  formComment.reset();
  clearTextCounter();
};


const pressKeySendComment = (event) => {
  const code = event.charCode || event.keyCode;
  if (code === 13 && !event.shiftKey) {
    event.preventDefault();
    send_comment_form();
  }
};

const pressBtnSendComment = () => {
  send_comment_form();
};

