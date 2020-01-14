class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,:validatable
  
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :book_comments, dependent: :destroy



  # フォローできるユーザーを取り出すに記述する。（user.following_relationships.followingsをできるようにする）
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  # フォローしているユーザーを取り出す （user.followingsをできるようにする）
  has_many :followings, through: :following_relationships
  # フォローされているユーザー
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  




  attachment :profile_image

  validates :name, presence: true, length: {maximum: 20, minimum: 2, message: "error"} 
  validates :introduction, length: {maximum: 50}

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end
end
