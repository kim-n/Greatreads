class User < ActiveRecord::Base
  attr_accessible :email, :name, :password

  validates :email, :session_token, presence: true
  validates :password_digest, :presence => { :message => "Password can't be blank" }
  # validates :password, :length => { :minimum => 6, :allow_nil => true }

  after_initialize :ensure_session_token

  has_many(
    :reviews,
    class_name: "Review",
    foreign_key: :user_id,
    primary_key: :id
  )

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
  
  
  def wish_books
    self.tastes.where(taste: 0).includes(:book)
  end
  
  def readBooks
    self.tastes.select("likes.*").where("likes.taste <> 0").includes(:book)
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
