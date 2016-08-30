class Post < ActiveRecord::Base
	after_create :send_email_to_subscribers
	
	ratyrate_rateable "content"
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :title, presence: true
	validates :content, presence: true

	private

	def send_email_to_subscribers
	  Subscribe.all.each do |subscribe|
	  	SubscribeMailer.send_email(subscribe.email, self).deliver_now
		end
	end

	def self.search(search)
  	where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%") 
	end

	def to_param
    [id, title.parameterize].join("-")
  end
end
