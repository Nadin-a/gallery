App.room = App.cable.subscriptions.create('ChatRoomsChannel', {
  connected: () => {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const newMessage = document.getElementById('new_messages');
    if (parseInt(newMessage.getAttribute('data-room-id'), 10) === parseInt(data.room, 10)) {
      const content = document.createElement('div');
      content.innerHTML = this.renderMessage(data.message);
      newMessage.appendChild(content);
      $preScrollable = $('#pre-scrollable');
      return $preScrollable.scrollTop($preScrollable[0].scrollHeight);
    }
    return true;
  },

  renderMessage(message) {
    return message;
  },

  send_message(message) {
    return this.perform('send_message', {
      message,
    });
  },
});

const sendMessageForm = () => {
  const formMessage = document.getElementById('message_input');
  const values = $(formMessage).serializeArray();
  App.room.send_message(values);
  formMessage.reset();
  clearTextCounter();
};

const pressKeySendMessage = (event) => {
  const code = event.charCode || event.keyCode;
  if (code === 13) {
    event.preventDefault();
    sendMessageForm();
  }
};

const pressBtnSendMessage = () => {
  sendMessageForm();
};

