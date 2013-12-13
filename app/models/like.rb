class Like < ActiveRecord::Base
  attr_accessible :book_id, :user_id, :taste
  
  validates :taste, :inclusion  => { :in => [ -1, 0, 1 ] }
  validates :book_id, :taste, :user, presence: true
  
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  ) 
  
  belongs_to(
    :book,
    class_name: "Book",
    foreign_key: :book_id,
    primary_key: :id
  ) 
  
  def self.find_rating (user_id, book_id)
    Like.find_by_user_id_and_book_id(user_id, book_id)
  end
end
