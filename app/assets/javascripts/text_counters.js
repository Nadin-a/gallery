$(document).ready(() => {

  // $text_area = $('.limited-text-input');
  //
  // if ($text_area.is(':visible')) {
  //   let text_max = 200;
  //   $('#count_message').html($text_area.val().length + '/' + text_max);
  //   $text_area.keyup(function () {
  //     let text_length = $text_area.val().length;
  //     $('#count_message').html(text_length + '/' + text_max);
  //   });
  // }

  const textarea = document.querySelector('textarea#comment_input');
  const countMessage = document.getElementById('count_message');
  const post = document.getElementById('btn-comment-post');
  textarea.addEventListener('input', function(){
    const maxlength = textarea.maxLength
    const currentLength = this.value.length;
    countMessage.innerHTML = currentLength + '/' + maxlength;
  });

  post.addEventListener('click', () => {
    countMessage.innerHTML = '';
  });

  $(document).keypress((e) => {
    let code = e.charCode || e.keyCode;
    if (code == 13) {
      countMessage.innerHTML = '';
    }
  });
});

