class Post < ActiveRecord::Base
	ratyrate_rateable "content"
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :replies, dependent: :destroy

	validates :title, presence: true
	validates :content, presence: true, length: { maximum: 140 }
end
