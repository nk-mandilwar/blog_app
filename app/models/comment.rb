class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :children, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Comment"

  validates :content, presence: true, length: { maximum: 140 }
  validates :post_id, presence: true
  validates :user_id, presence: true
end
