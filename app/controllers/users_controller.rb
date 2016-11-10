 class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:new, :create]
	before_action :get_user, except: :index
	before_action :check_user, only: [:edit, :update, :destroy]
	
	def index
		if params[:search]
			@users = User.search(params[:search]).page params[:page]
		else
			@users = User.all.page params[:page]
		end
		@relationships = User.fetch_user_relationship(@users, current_user)
		@friendships = User.fetch_user_friendship(@users, current_user)
		@friend_requests = User.fetch_user_friend_request(@users, current_user)
	end

	def new
		@user = User.new
	end

	def create
		binding.pry
		redirect_to root_path unless session["devise.user_attributes"]["uid"]
		@user = User.new(create_user_params)
		if @user.save
			redirect_to home_path
		else
			render 'users/new'
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
			@relationship = current_user.active_relationships.find_by(followed_id: @user)
			@friendship = current_user.friendships.find_by(friend_id: @user)
			@friend_request = { received_request: current_user.received_friend_requests.find_by(user_id:  @user),
                         sent_request: current_user.friend_requests.find_by(friend_id: @user) }
			@posts = @user.posts.order("updated_at DESC").page params[:page]
		end
	end

	def following
		@users = @user.following.page params[:page]
		@relationships = User.fetch_user_relationship(@users, current_user)
	end

	def followers
		@users = @user.followers.page params[:page]
		@relationships = User.fetch_user_relationship(@users, current_user)
	end

	private

	def get_user
		@user = User.find_by(:id => params[:id])
		redirect_to users_path unless @user
	end

	def check_user
		if @user != current_user
			redirect_to users_path, notice: "Cannot access other user page" 
		end
	end

	def user_params
		params.require(:user).permit(:name, :city, :twitter_profile, :image, :remove_image)
	end

	def create_user_params
		params.require(:user).permit(:name, :twitter_profile, :email, :username, :uid, :provider)
	end	
end