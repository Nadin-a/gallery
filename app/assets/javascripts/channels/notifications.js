const show_notification = () => {
  let snackbar = document.getElementById('snackbar');
  snackbar.className = 'show';
  setTimeout(function () {
    snackbar.className = snackbar.className.replace('show', '');
  }, 3000);
  let newNotification = document.getElementById('new_notification_in_snackbar');
  newNotification.innerHTML = '';
};

App.notifications = App.cable.subscriptions.create('NotificationChannel', {
  connected: () => {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    // Called when the subscription has been terminated by the server
  },

  received: data => {
    // Called when there's incoming data on the websocket for this channel
    show_notification();
    let newNotificationInList = document.getElementById('new_notification_in_list');
    let newNotification = document.createElement('div');
    newNotification.innerHTML = data.notification;
    newNotificationInList.appendChild(newNotification);
    newNotificationInList.insertBefore(newNotification, newNotificationInList.firstChild);

    let newNotificationInSnackbar = document.getElementById('new_notification_in_snackbar');
    newNotificationInSnackbar.innerHTML = data.notification;

    let counterOfNotification = document.getElementById('counter_of_notification');
    counterOfNotification.innerHTML = '🔔 ' + data.counter;
  }
});

