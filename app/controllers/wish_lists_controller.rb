class WishListsController < ApplicationController

  def create
    # render :json => params
    current_user.wish_items.create(
      book_id: params[:book_id]
    )
    book = Book.find(params[:book_id])
    redirect_to book_url(book.isbn)
  end

  def destroy
    wishItem = WishList.find(params[:id])
    wishItem.delete
    book = Book.find(params[:book_id])
    redirect_to book_url(book.isbn)
  end
end
