class SubscribeMailer < ApplicationMailer
	def send_email(email,post)    
	  @post = post
	  @subscribe = Subscribe.find_by(email: email)
	  mail to: email, subject: @post.title
	end
end