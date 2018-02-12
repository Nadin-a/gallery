const showHiddenComments = () => {
  const showAllComments = document.getElementById('show_all_comments_link');
  const hiddenComments = document.getElementById('hidden_comments');

  $.ajax({
    dataType: 'JSON',
    method: 'get',
    success(data) {
      hiddenComments.innerHTML = data.hidden_comments;
      showAllComments.style.display = 'none';
    }
  });
};

