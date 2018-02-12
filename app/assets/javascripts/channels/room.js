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
    if (newMessage.getAttribute('data-room-id') == data.room) {
      const content = document.createElement('div');
      content.innerHTML = this.renderMessage(data.message);
      newMessage.appendChild(content);
      return $('#pre-scrollable').scrollTop($('#pre-scrollable')[0].scrollHeight);
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

const send_message_form = () => {
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
    send_message_form();
  }
};

const pressBtnSendMessage = () => {
  send_message_form();
};

