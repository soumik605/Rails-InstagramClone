class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  acts_as_follower
  acts_as_followable


  validates :first_name, presence: true, allow_blank: false, length: { minimum: 3 }
  validates :last_name, presence: true, allow_blank: false, length: { minimum: 2 }
  validates :username, uniqueness: { case_sensitive: true },
                       format: { with: /\A[a-zA-Z0-9]+\z/ },
                       presence: true,
                       allow_blank: false

  validates :email, presence: true, allow_blank: false, uniqueness: true
  validates :phone, length: { in: 10..12 }


  def liked?(post)
    likes.find_by(post_id: post.id).present?
  end

  def like(post)
    likes.find_or_create_by(post: post)
    post.reload
  end

  def unlike(post)
    likes.where(post: post).destroy_all
    post.reload
  end

  def fullname
    first_name+ " "+last_name
  end

  def followUser(user)
    follow(user)  if !current_user.following?(@user)
  end

  def unfollowUser(user)
    stop_following(user)  if current_user.following?(@user)
  end

  scope :all_except, ->(id) { where.not(id: id) }




end
