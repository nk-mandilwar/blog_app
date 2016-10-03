class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def twitter				
		user = User.from_omniauth(request.env.with_indifferent_access['omniauth.auth'])
		if user.persisted?
			flash.notice = "signed in"
			sign_in_and_redirect user
		else
			session["devise.user_attributes"] = user.attributes
			render 'registration'
			redirect_to new_user_registration_path
		end
	end

	def registration
	end

	def failure
    redirect_to root_path
  end
end
