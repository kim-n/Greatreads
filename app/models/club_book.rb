class ClubBook < ActiveRecord::Base
  attr_accessible :book_id
  
  validates :club_id, :book_id, presence: true
  
  belongs_to(
    :club,
    class_name: "Club",
    foreign_key: :club_id,
    primary_key: :id,
    inverse_of: :book_pairings
  )
  
  belongs_to(
    :book,
    class_name: "Book",
    foreign_key: :book_id,
    primary_key: :id,
    inverse_of: :club_pairngs
  )
end

