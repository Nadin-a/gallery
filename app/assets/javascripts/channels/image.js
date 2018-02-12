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
    if (parseInt(newComment.getAttribute('data-image-id'),10) === parseInt(data.image, 10)) {
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

const sendCommentForm = () => {
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
    sendCommentForm();
  }
};

const pressBtnSendComment = () => {
  sendCommentForm();
};

