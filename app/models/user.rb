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


  def liked_books
    books = []
    self.likes.each do |like|
      books << like.book
    end
    books
  end

  def disliked_books
    books = []
    self.dislikes.each do |like|
      books << like.book
    end
    books
  end

  def reviewed_books
    books = []
    self.reviews.each do |review|
      books << review.book
    end
    books
  end

  def read_books
    likes = self.tastes.where("likes.taste <> 0")
  end

  def self.valid_users
    User.where("admin > -1")
  end

  def self.requests
    User.where("admin = -1 AND created_at = updated_at")
  end

  def self.pending
    User.where("admin = -1 AND created_at <> updated_at")
  end


  def recommendations

    my_liked_books = self.liked_books
    my_liked_books.shuffle!

    my_disliked_books = self.disliked_books
    my_reviewed_books = self.reviewed_books

    recs = []
    my_liked_books.each do |book|
      likes_of_book = Like.where("taste = ? AND book_id = ? AND user_id <> ?", 1, book.id, self.id )


      # all other users who like book
      users_like_book = []
      likes_of_book.each do |like|
        users_like_book << like.user
      end

      users_like_book.each do |user|
        user.liked_books.each do |book|
          unless my_liked_books.include?(book) || my_disliked_books.include?(book) ||my_reviewed_books.include?(book)

            recs << book
          end
        end
      end

    end

    # recs
  end


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
