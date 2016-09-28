 class UsersController < ApplicationController
 	before_action :authenticate_user!
 	before_action :set_user, except: :index
	
	def index
		if params[:search]
    	@users = User.search(params[:search]).page params[:page]
  	else
    	@users = User.all.page params[:page]
    end
	end

	def edit
		unless @user == current_user
      redirect_to edit_user_path(current_user), notice: "Cannot access other user edit page" 
    end
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

	def user_params
    params.require(:user).permit(:name, :city, :twitter_profile, :image, :remove_image)
  end
end