App.room = App.cable.subscriptions.create('ChatRoomsChannel', {
  connected: function () {
    console.log('connected');
    // Called when the subscription is ready for use on the server
  },

  disconnected: function () {
    console.log('disconnected');
    // Called when the subscription has been terminated by the server
  },

  received: function (data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data);
    $current_url = window.location.href;
    if ($current_url.includes(data.url)) {
      return $('#new_messages').append(this.renderMessage(data.message));
    }
  },

  renderMessage: function (message) {
    return message;
  }

});
