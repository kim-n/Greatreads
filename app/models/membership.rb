class Membership < ActiveRecord::Base
  attr_accessible :club_id, :user_id

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :club_memberships
  )

  belongs_to(
    :club,
    class_name: "Club",
    foreign_key: :club_id,
    primary_key: :id,
    inverse_of: :user_memberships
  )
end
