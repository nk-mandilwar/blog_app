 class UsersController < ApplicationController
 	before_action :authenticate_user!
 	before_action :set_user, except: :index
	
	def index
		if params[:search]
    	@users = User.search(params[:search])
  	else
    	@users = User.all
    end
	end

	def edit
		unless @user && @user == current_user
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
	end

	def update
		if @user.update(user_params)
			redirect_to  new_user_session_url
		else
			render "edit"
		end	
	end

	def show
		unless @user
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
	end

	def following
    @users = @user.following
  end

  def followers
    @users = @user.followers
  end

	private

	def set_user
		@user = User.find_by(:id => params[:id])
	end

	def user_params
    params.require(:user).permit(:name, :email, :username, :city, :facebook_profile, :image, :remove_image)
  end
end