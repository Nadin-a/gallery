$(document).ready(() => {
  $current_url = window.location.href;
  if ($current_url.includes('rooms/')) {
    document.getElementById('btn-message-post').scrollIntoView();
  }

  $(() => {
    $('[data-toggle="popover"]').popover({
      html: true,
      container: 'body'
    });
  })

});