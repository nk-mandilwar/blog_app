class Post < ActiveRecord::Base
	after_create :send_email_to_subscribers
	
	ratyrate_rateable "content"
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :title, presence: true, length: {maximum: 150}
	validates :content, presence: true

	def to_param
    [id, title.parameterize].join("-")
  end
  
	private

	def send_email_to_subscribers
	  Subscribe.all.each do |subscribe|
	  	SubscribeMailer.delay.send_email(subscribe.email, self)
		end
	end

	def self.search(search)
  	where("title LIKE :search", {search: "%#{search}%"}).order("updated_at DESC")
	end
end
