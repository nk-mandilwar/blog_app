class Reply < ActiveRecord::Base
  belongs_to :comment
  belongs_to :post
  belongs_to :user


  validates :content, presence: true, length: { maximum: 140 }
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :comment_id, presence: true
end
