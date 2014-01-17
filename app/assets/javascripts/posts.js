$(document).ready(function (){

  // on successful post creation
  $("body").on("ajax:success", ".post-form", function (event, data) {
    event.preventDefault();
    $postForm = $(this)

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

    $insertion = $(".my-post");
    $insertion.children(".sub-title").html("My Review");
    $insertion.append(data);

    $insertion.children("form").remove();

  });

  $("body").on("ajax:success", ".post-delete-form", function (event, data) {
    event.preventDefault();
    
    $insertion = $(".my-post")
    $insertion.children(".sub-title").html("New Review")
    $insertion.append(data)


    $insertion.children(".post").remove()
  });
  
  
  $("body").on("ajax:error", ".post-delete-form", function (event, data) {
    console.log("ERROR DELETING POST")
  });
  
  $("body").on("ajax:success", ".like-form", function (event, data) {
    event.preventDefault();
    
    console.log(data)
    $insertion = $(".likes-section")
    
    $insertion.html(data)

  });

});