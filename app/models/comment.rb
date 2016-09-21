class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :children, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Comment"
  has_many :likes, dependent: :destroy
  has_many :liked_by, through: :likes, source: :user

  validates :content, presence: true, length: { maximum: 10000}
  validates :post_id, presence: true
  validates :user_id, presence: true
end
