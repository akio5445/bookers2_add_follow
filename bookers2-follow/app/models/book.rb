class Book < ApplicationRecord
	belongs_to :user, optional: true

	has_many :favorites, dependent: :destroy
	has_many :iine_users, through: :favorites, source: :user

	has_many :book_comments, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200, message: "error"}

	# マイクロポストをいいねする
  def iine(user)
    favorites.create(user_id: user.id)
  end

  # マイクロポストのいいねを解除する（ネーミングセンスに対するクレームは受け付けません）
  def uniine(user)
    favorites.find_by(user_id: user.id).destroy
	end
	
	# 現在のユーザーがいいねしてたらtrueを返す
  def iine?(user)
    iine_users.include?(user)
  end
end
