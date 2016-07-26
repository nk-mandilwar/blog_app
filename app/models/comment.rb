class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates :content, presence: true, length: { maximum: 140 }
  validates :post_id, presence: true
  validates :user_id, presence: true
end
