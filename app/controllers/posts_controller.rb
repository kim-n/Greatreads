class PostsController < ApplicationController

  before_filter :require_current_user!
  before_filter :no_double_review!, only: [:create_review]


  def create
    post = current_user.posts.new(params[:post])
    post.club_id = params[:club_id]
    club = Club.find(params[:club_id])

    is_saved = post.save

    unless is_saved
      flash[:errors] = post.errors.full_messages
    end

    if request.xhr?
      if is_saved
        # Notify user.followers that user made post
        current_user.notify_followers_new_post(post)

        # Notify club.members that new post made
        club.notify_members_new_post(post)

        render partial: "posts/post", locals: {post: post}
      else
        render json: post.errors.full_messages, status: :unprocessable_entity
      end
    else
      # Notify user.followers that user made post
      current_user.notify_followers_new_post(post)
      # Notify club.members that new post made
      club.notify_members_new_post(post)

      redirect_to club_url(club)
    end
  end

  # Creates a REVIEW
  def create_review
    review = current_user.posts.new(params[:post])

    review.book_id = params[:book_id]

    is_saved = review.save

    unless is_saved
      flash[:errors] = review.errors.full_messages
    end

    # remove book from wish list if it was there
    like = Like.where(user_id: current_user.id, book_id: params[:book_id],  taste: 0)[0]
    like.destroy if like

    if request.xhr?
      if is_saved
        # Notify user.followers that user made review
        current_user.notify_followers_new_review(review)

        render partial: "posts/post", locals: {post: review}
      else
        render json: review.errors.full_messages, status: :unprocessable_entity
      end
    else
      book = Book.find(params[:book_id])
      # Notify user.followers that user made review
      current_user.notify_followers_new_review(review)

      redirect_to book_url(book.isbn)
    end

  end

  def no_double_review!
    book = Book.find(params[:book_id])
    @review = Post.review_for(current_user.id, book.id)

    unless @review.nil?
      flash[:errors] = ["Can't double review"]
      redirect_to book_url(book.isbn)
    end
  end


end
