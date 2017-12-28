App.image = App.cable.subscriptions.create('ImageChannel', {
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
    var current_url = window.location.href;
    if (current_url.includes(data.url)) {
      $like_label.html(data.count);
      if(data.comment) {
        return $('#new_comments').append(this.renderComment(data));
      }
    }
  },

  renderComment: function(data) {
    return "<br><br><p> <b>" + data.author + ": </b><br><br>" + data.comment.content + "</p>" + data.date;
  }

});