$(document).ready(function () {
  $current_url = window.location.href;
  if ($current_url.includes('rooms/')) {
    document.getElementById('btn-message-post').scrollIntoView();
  }

});