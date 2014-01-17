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
    $('.comment-form input[type="submit"]').hide();
    
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


  $('.comment-form input[type="submit"]').hide();
  $('body').on('focus', '.comment-text', function (event){
      $('.comment-form input[type="submit"]').hide();
      $(this).parent().children('input[type="submit"]').show();
  });

  
  $("body").on("ajax:success", ".comment-delete-form", function (event, data) {
  console.log($(this))
    event.preventDefault();
    $(this).parent().remove();
  });
  
  
  $("body").on("ajax:error", ".comment-delete-form", function (event, data) {
    console.log("ERROR DELETING COMMENT")
    console.log(data)
  });


});