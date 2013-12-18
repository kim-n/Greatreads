$(document).ready(function (){

  // on successful post creation
  $("body").on("ajax:success", ".post-form", function (event, data) {
    event.preventDefault();

    $postsList = $(this).parent().siblings(".posts-list");
    $postsList.append(data);
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

    $postsList = $(this).parent().siblings(".posts-list");
    $postsList.append(data);

    $postForm = $(this).parent()
    $postForm.append(data)
    
    $postForm.children(".sub-title").html("My Review")
    $postForm.children("form").html("")
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