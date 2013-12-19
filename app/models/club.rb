class Club < ActiveRecord::Base
  attr_accessible :title

  validates :title, :creator, presence: true

  belongs_to(
    :creator,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :club_id,
    primary_key: :id
  )

  has_many(
    :book_pairings,
    class_name: "ClubBook",
    foreign_key: :club_id,
    primary_key: :id,
    inverse_of: :club
  )

  has_many :books, through: :book_pairings, source: :book

  has_many(
    :user_memberships,
    class_name: "Membership",
    foreign_key: :club_id,
    primary_key: :id,
    inverse_of: :club
  )

  has_many :members, through: :user_memberships, source: :user

  def notify_members_new_post(post)
    self.members.each do |member|
      Notification.create(
        user_id: member.id,
        obj_type: "Club",
        obj_id: post.id
      )
    end
  end
end
