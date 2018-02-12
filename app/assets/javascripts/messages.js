document.addEventListener('DOMContentLoaded', () => {
  const currentUrl = window.location.href;
  if (currentUrl.includes('rooms/')) {
    document.getElementById('btn-message-post').scrollIntoView();
  }

  $(() => {
    $('[data-toggle="popover"]').popover({
      html: true,
      container: 'body',
    });
  });
});
