const show_notification = () => {
  // Get the snackbar DIV
  $('#snackbar').addClass('show');
  // After 3 seconds, remove the show class from DIV
  setTimeout(() => $('#snackbar').removeClass('show'), 3000);
  $(".new_notification_in_snackbar").html('');
};

App.notifications = App.cable.subscriptions.create('NotificationChannel', {
  connected: () => {
    console.log('connected')
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    console.log('disconnected')
    // Called when the subscription has been terminated by the server
  },

  received: data => {
    console.log(data);
    // Called when there's incoming data on the websocket for this channel
    show_notification();
    $(".new_notification").append(data.notification);
    $(".new_notification_in_snackbar").append(data.notification);
    $("#couner_of_notification").html('🔔 ' + data.counter);
  }
});

