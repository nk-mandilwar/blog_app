 class UsersController < ApplicationController
 	before_action :authenticate_user!
 	before_action :set_user, except: :index
 	before_action :check_user, only: [:edit, :update]
	
	def index
		if params[:search]
    	@users = User.search(params[:search]).page params[:page]
  	else
    	@users = User.all.page params[:page]
    end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to user_path(@user), notice: "Updated Successfully"
		else
			render "edit"
		end		
	end

	def show
		if !@user
      redirect_to users_path, notice: "The user you are looking for does not exist"  
  	else
    	@posts = @user.posts.order("updated_at DESC").page params[:page]
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

	def check_user
		if @user != current_user
      redirect_to users_path, notice: "Cannot access other user page" 
    end
	end

	def user_params
    params.require(:user).permit(:name, :city, :twitter_profile, :image, :remove_image)
  end
end