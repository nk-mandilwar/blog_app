class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	# def passthru
	# 	binding.pry
	# 	self.resource = resource_class.new
	# 	render 'devise/registrations/new'
	# end

	def twitter				
		binding.pry
		user = User.from_omniauth(request.env["ominauth.auth"])		
		if user.persisted?
			sign_in_and_redirect user, notice: "signed in"
		else
			session[devise.user_attributes] = user.attributes
			redirect_to new_user_registration_path
		end
	end


	def failure
    redirect_to root_path
  end
	# alias_method :twitter, all
end
