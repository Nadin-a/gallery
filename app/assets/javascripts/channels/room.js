App.room = App.cable.subscriptions.create('ChatRoomsChannel', {
  connected: () => {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    // Called when there's incoming data on the websocket for this channel
    let newMessage = document.getElementById('new_messages');
    if (newMessage.getAttribute('data-room-id') == data.room) {

      let content = document.createElement('div');
      content.innerHTML = this.renderMessage(data.message);
      newMessage.appendChild(content);
      return $('#pre-scrollable').scrollTop($('#pre-scrollable')[0].scrollHeight);
    }
  },

  renderMessage: function (message) {
    return message;
  },

  send_message: function (message) {
    return this.perform('send_message', {
      message: message
    });
  }
});

const pressKeySendMessage = (event) => {
  let code = event.charCode || event.keyCode;
  if (code === 13) {
    event.preventDefault();
    send_message_form();
  }
};

const pressBtnSendMessage = () => {
  send_message_form();
};

const send_message_form = () => {
  let formMessage = document.getElementById('message_input');
  let values = $(formMessage).serializeArray();
  App.room.send_message(values);
  formMessage.reset();
};
