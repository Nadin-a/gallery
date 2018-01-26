App.notifications = App.cable.subscriptions.create('NotificationChannel', {
  connected: function() {
    console.log('connected')
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    console.log('disconnected')
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    console.log(data);
    // Called when there's incoming data on the websocket for this channel
    show_notification();
    $(".new_notification").append(data.notification);
    $("#couner_of_notification").html('🔔 ' + data.counter);
  }
});

