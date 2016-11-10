class OmniauthCallbacksController < Devise::OmniauthCallbacksController

	def twitter				
		@user = User.from_omniauth(request.env.with_indifferent_access['omniauth.auth'])
		if @user.persisted?
			flash.notice = "signed in"
			sign_in_and_redirect @user
		else
			session["devise.user_attributes"] = @user.attributes
			render 'users/new'
		end
	end

	def failure
    redirect_to root_path
  end
	# alias_method :twitter, all
end
