App.room = App.cable.subscriptions.create('ChatRoomsChannel', {
  connected: () => {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    // Called when there's incoming data on the websocket for this channel
    if ($("#new_messages").attr('data-room-id') == data.room) {
      return $('#new_messages').append(this.renderMessage(data.message));
    }
  },

  renderMessage: function (message) {
    return message;
  },

  send_message: function (message) {
    console.log(message);
    return this.perform('send_message', {
      message: message
    });
  }
});

  $(document).on('keypress', '.new_message', function (e) {
    let code = e.charCode || e.keyCode;
    if (code == 13) {
      e.preventDefault();
      var values = $(this).serializeArray();
      App.room.send_message(values);
      $(this).trigger('reset');
    }
  });

  $(document).on('submit', '.new_message', function (e) {
    e.preventDefault();
    let values = $(this).serializeArray();
    App.room.send_message(values);
    $(this).trigger('reset');
  });
