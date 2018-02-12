$(() => {
  function onNavbar() {
    if (window.innerWidth >= 768) {
      $('.navbar-default .dropdown').on('mouseover', function () {
        $('.dropdown-toggle', this).next('.dropdown-menu').show();
      }).on('mouseout', function () {
        $('.dropdown-toggle', this).next('.dropdown-menu').hide();
      });
      $('.dropdown-toggle').click(function () {
        if ($(this).next('.dropdown-menu').is(':visible')) {
          window.location = $(this).attr('href');
        }
      });
    } else {
      $('.navbar-default .dropdown').off('mouseover').off('mouseout');
    }
  }

  $(window).resize(() => {
    onNavbar();
  });
  onNavbar();
});

(function ($) {
  $(document).ready(() => {
    $('#navbar-main').prepend('<div id="bg-one"></div><div id="bg-two"></div><div id="bg-three"></div><div id="bg-four"></div>');
  });
}(jQuery));

