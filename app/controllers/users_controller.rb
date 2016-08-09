 class UsersController < ApplicationController
 	before_action :authenticate_user!
	
	def index
		@users = User.all
	end

	def edit
		@user = User.find(current_user)
	end

	def update
		@user = User.find(current_user)
		if @user.update_with_password(user_params)
			redirect_to  new_user_session_url
		else
			render "edit"
		end	
	end

	def show
		@user = User.find(params[:id])
	end

	def following
    @user  = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end

	private

	def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end