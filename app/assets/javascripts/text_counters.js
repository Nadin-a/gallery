$(document).ready(() => {
  const messageBody = document.getElementsByName('content')[0];
  const countSymbolsOfMessage = document.getElementById('count_message');
  const post_btns = document.getElementsByName('post_message');
  messageBody.addEventListener('input', function () {
    const maxlength = messageBody.maxLength;
    const currentLength = this.value.length;
    countSymbolsOfMessage.innerHTML = currentLength + '/' + maxlength;
  });

  post_btns.forEach((elem) => {
    elem.addEventListener('click', () => {
      countSymbolsOfMessage.innerHTML = '';
    });
  });


  $(document).keypress((e) => {
    let code = e.charCode || e.keyCode;
    if (code == 13) {
      countSymbolsOfMessage.innerHTML = '';
    }
  });
});



