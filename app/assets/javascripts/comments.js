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


    $newComments = $commentForm.parent().siblings(".new-comment")

    $errors = $newComments.children(".errors")
    $errors.remove();

    $newComments.prepend(data);
    $(this)[0].reset()
  });

  // on unsuccessful comment creation
  $("body").on("ajax:error", ".comment-form", function (event, data) {
    event.preventDefault();
    $commentForm = $(this)
    $newComments = $commentForm.parent().siblings(".new-comment")


    console.log("this", $(this))
    console.log("parent", $(this).parent())
    console.log("new comment", $newComments)
    $errors = $newComments.children(".errors")
    $errors.remove();

    $newComments.append('<div class="errors">' + data.responseText + '</div>');
  });



  // On click of comment button drop down of comments appear
  $("body").on("click", ".reply-button", function (event){
    event.preventDefault();

    $commentButton = $(this)

    $(".reply-button").removeClass("hide-tag")
    $(this).toggleClass("hide-tag")

    $(".reply-form").addClass("hide-tag")
    $commentButton.siblings(".reply-form").toggleClass("hide-tag")
  });



});