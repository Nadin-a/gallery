const showNotification = () => {
  const snackbar = document.getElementById('snackbar');
  snackbar.className = 'show';
  setTimeout(() => {
    snackbar.className = snackbar.className.replace('show', '');
  }, 3000);
  const newNotification = document.getElementById('new_notification_in_snackbar');
  newNotification.innerHTML = '';
};

App.notifications = App.cable.subscriptions.create('NotificationChannel', {
  connected: () => {
    // Called when the subscription is ready for use on the server
  },

  disconnected: () => {
    // Called when the subscription has been terminated by the server
  },

  received: (data) => {
    // Called when there's incoming data on the websocket for this channel
    showNotification();
    const newNotification = document.createElement('div');
    newNotification.innerHTML = data.notification;


    console.log(data.notification);
    const newNotificationInSnackbar = document.getElementById('new_notification_in_snackbar');
    newNotificationInSnackbar.innerHTML = data.notification;

    const counterOfNotification = document.getElementById('counter_of_notification');
    counterOfNotification.innerHTML = `🔔 ${data.counter}`;


    const newNotificationInList = document.getElementById('new_notification_in_list');
    if(newNotificationInList !== null) {
      newNotificationInList.appendChild(newNotification);
      newNotificationInList.insertBefore(newNotification, newNotificationInList.firstChild);
    }
  },
});
