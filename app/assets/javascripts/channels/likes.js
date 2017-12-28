App.image = App.cable.subscriptions.create('LikesChannel', {
  connected: function() {
     console.log('connected');
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    console.log('disconnected');
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    //$('#notifications').prepend(data.html);
    console.log(data);
    $like_label.html(data.count);
  }
});