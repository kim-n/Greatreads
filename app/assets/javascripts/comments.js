$(document).ready(function (){

  // On click of comment button drop down of comments appear
  $("body").on("click", ".comment-button", function (event){
    event.preventDefault();
    $commentButton = $(this)
    $(".post-comments").addClass("hide-tag")
    $commentButton.parent().next().toggleClass("hide-tag")
  });

  // On successful comment creation
  $("body").on("ajax:success", ".comment-form", function (event, data) {
    event.preventDefault();

    $commentForm = $(this)
    $commentsList = $commentForm.siblings(".comments-list")

    $errors = $commentsList.children(".errors")
    $errors.remove();

    $commentsList.append(data);
    $(this)[0].reset()
  });

  // on unsuccessful comment creation
  $("body").on("ajax:error", ".comment-form", function (event, data) {
    event.preventDefault();

    $commentForm = $(this)
    $commentsList = $commentForm.siblings(".comments-list")

    $errors = $commentsList.children(".errors")
    $errors.remove();

    $commentsList.append('<div class="errors">' + data.responseText + '</div>');
  });

});