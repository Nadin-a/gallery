const show_hidden_comments = () => {
  let showAllComments = document.getElementById('show_all_comments_link');
  let hiddenComments = document.getElementById('hidden_comments');

  $.ajax({
    dataType: 'JSON',
    method: 'get',
    success: function (data) {
      hiddenComments.innerHTML = data.hidden_comments;
      showAllComments.style.display = "none";
    },
    error: function (error) {
      console.log(error);
    }
  });
};


