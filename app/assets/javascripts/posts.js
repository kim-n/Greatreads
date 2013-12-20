$(document).ready(function (){

  // on successful post creation
  $("body").on("ajax:success", ".post-form", function (event, data) {
    event.preventDefault();

    $errors = $postForm.children(".errors")
    $errors.remove();

    $postsList = $(this).parent().siblings(".posts-list");
    $postsList.prepend(data);
  });

  // on unsuccessful post creation
  $("body").on("ajax:error", ".post-form", function (event, data) {
    event.preventDefault();

    $postForm = $(this)

    $errors = $postForm.children(".errors")
    $errors.remove();

    $postForm.prepend('<div class="errors">'+ data.responseText +'</div>')
  });


  // on successful review creation
  $("body").on("ajax:success", ".review-form", function (event, data) {
    event.preventDefault();

    // $postsList = $(this).parent().siblings(".posts-list");
    // $postsList.prepend(data);

    $postForm = $(this).parent()
    $postForm.append(data)

    $errors = $postForm.children(".errors")
    $errors.remove();

    $postForm.children(".sub-title").html("My Review")
    $postForm.children("form").html("")
    $postForm[0].reset()

  });

  // on unsuccessful review creation
  $("body").on("ajax:error", ".review-form", function (event, data) {
    event.preventDefault();

    $postForm = $(this)

    $errors = $postForm.children(".errors")
    $errors.remove();

    $postForm.prepend('<div class="errors">'+ data.responseText +'</div>')
  });

});