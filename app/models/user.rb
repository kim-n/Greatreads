class User < ActiveRecord::Base
  # remove admin from attr_accessable
  attr_accessible :email, :name, :password, :admin, :image

  validates :email, :session_token, presence: true
  validates :password_digest, :presence => { :message => "Password can't be blank" }
  # validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :admin, :inclusion  => { :in => [ -1, 0, 1, 2 ] }

  after_initialize :ensure_session_token


  has_many(
    :created_clubs,
    class_name: "Club",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :tastes,
    class_name: "Like",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many :rated_books, through: :tastes, source: :book

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :follower_entries,
    class_name: "Follow",
    foreign_key: :follower_id,
    primary_key: :id,
    inverse_of: :follower
  )

  has_many(
    :followee_entries,
    class_name: "Follow",
    foreign_key: :followee_id,
    primary_key: :id,
    inverse_of: :followee
  )

  has_many :followers, through: :followee_entries, source: :follower

  has_many :follows, through: :follower_entries, source: :followee

  has_many(
    :notifications,
    class_name: "Notification",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user
  )

  has_many(
    :club_memberships,
    class_name: "Membership",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user
  )

  has_many :clubs, through: :club_memberships, source: :club

  def reviews
    Post.user_reviews(self.id)
  end

  def post_items
    Post.user_posts(self.id)
  end

  def wish_books
    self.tastes.where(taste: 0)
  end

  def likes
    self.tastes.where(taste: 1)
  end

  def dislikes
    self.tastes.where(taste: -1)
  end

  def read_books_with_rating
    book_ids = []
    book_rating_pairs = []
    self.tastes.each do |like|
      if like.taste == 1
        book_ids << like.book_id
        book_rating_pairs << {taste: "^", book: like.book}
      elsif like.taste == -1
        book_ids << like.book_id
        book_rating_pairs << {taste: "v", book: like.book}
      end
    end

    self.reviews.each do |review|
      unless book_ids.include?(review.book_id)
        book_ids << review.book_id
        book_rating_pairs << {taste: "-", book: review.book}
      end
    end

    book_rating_pairs
  end

  def read_books
    book_rating_pairs = self.read_books_with_rating
    books = []
    book_rating_pairs.each do |pair|
      books << pair[:book]
    end
    books
  end

  def liked_books
    books = []
    self.likes.each do |like|
      books << like.book
    end
    books
  end

  # def disliked_books
  #   books = []
  #   self.dislikes.each do |like|
  #     books << like.book
  #   end
  #   books
  # end
  #
  # def reviewed_books
  #   books = []
  #   self.reviews.each do |review|
  #     books << review.book
  #   end
  #   books
  # end

  def self.valid_users
    User.where("admin > -1")
  end

  def self.requests
    User.where("admin = -1 AND created_at = updated_at")
  end

  def self.pending
    User.where("admin = -1 AND created_at <> updated_at")
  end

####---Recomendations-----####

  def recommendations

    user_likes_books = self.liked_books
    user_likes_books.shuffle!

    all_my_read_books = self.read_books

    recommendations = []
    user_likes_books.each do |book|
      likes_of_book = Like.where("taste = ? AND book_id = ? AND user_id <> ?", 1, book.id, self.id )

      # all other users who like book
      users_who_like_book = []
      likes_of_book.each do |like|
        users_who_like_book << like.user
      end

      users_who_like_book.each do |user|
        user.liked_books.each do |book|
          unless all_my_read_books.include?(book)
            recommendations << book
          end
        end
      end
    end

    books = Book.all.shuffle!
    until recommendations.count >= 5 || books.count <= 0
      book = books.shift
      unless all_my_read_books.include?(book) || recommendations.include?(book)
        recommendations << book
      end
    end

    recommendations
  end


####---Notifications-----####
  def send_notifications(new_object)
    self.followers.each do |follower|
      Notification.send_notification(new_object, follower)
    end
  end


####---Session && New User-----####

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
