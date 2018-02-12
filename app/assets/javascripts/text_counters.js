const clearTextCounter = () => {
  const countSymbolsOfMessage = document.getElementById('count_message');
  countSymbolsOfMessage.innerHTML = '';
};

document.addEventListener('DOMContentLoaded', () => {
  const messageBody = document.getElementsByName('content')[0];
  const countSymbolsOfMessage = document.getElementById('count_message');
  const postBtns = document.getElementsByName('post_message');
  if(messageBody !== undefined) {
    messageBody.addEventListener('input', function () {
      const maxlength = messageBody.maxLength;
      const currentLength = this.value.length;
      countSymbolsOfMessage.innerHTML = `${currentLength}/${maxlength}`;
    });
  }

  postBtns.forEach((btn) => {
    btn.addEventListener('click', () => {
      clearTextCounter();
    });
  });
});
