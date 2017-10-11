class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_post, except: :liked_by
	before_action :check_user, only: [:edit, :update]
	before_action :check_post_user, only: :destroy

	def new
		@comment = Comment.find_by(id: params[:comment_id])
    @left_margin = calculate_left_margin(@comment)
		respond_to do |format|
			format.js
		end
	end

	def create
		@comment = Comment.create(comment_params.merge({post_id: @post.id, user_id: current_user.id}))
    @like = Like.find_by(:comment_id => @comment.id, :user_id => current_user.id)
    @parent_comment = Comment.find_by(id: @comment.parent_id)
    @no_of_children = set_no_of_children(@parent_comment)
    @left_margin = calculate_left_margin(@parent_comment)
		respond_to do |format|
			format.html {redirect_to post_path(@post)}
			format.js
		end
	end

	def destroy
		@comment_ids = [@comment.id]
		if(@comment.children)
			find_all_child_comment(@comment.children)
		end
    @comment.destroy
    if @comment.parent_id
      @no_of_children = Comment.find_by(id: @comment.parent_id).children.length
    end
    respond_to do |format|
    	format.html {redirect_to post_path(@post)}
    	format.js
    end
  end

  def edit
  	respond_to do |format|
  		format.js
  	end
  end

  def update
    @like = Like.find_by(:comment_id => @comment.id, :user_id => current_user.id)
  	@comment.update(comment_params)
  	respond_to do |format|
  		format.js
  	end
  end

  def liked_by
  	@comment = Comment.find_by(id: params[:id])
  	@users = @comment.liked_by.page params[:page]
  	@relationships = User.fetch_user_relationship(@users, current_user)
		@friendships = User.fetch_user_friendship(@users, current_user)
		@friend_requests = User.fetch_user_friend_request(@users, current_user)
  end

  def show
    @comment = @post.comments.find_by(id: params[:id])
    redirect_to post_path(@post) unless @comment
    @comments = @comment.get_children
    @current_user_likes = Comment.get_user_likes(@comments, current_user.id)
    @left_margin = calculate_left_margin(@comment)
    respond_to do |format|
      format.js
    end
  end

	private

		def comment_params
			params.require(:comment).permit(:content, :parent_id, :base_id, :level)
		end

		def get_post
			@post = Post.find_by(id: params[:post_id])
			redirect_to posts_path unless @post
		end

		def check_post_user
			@comment = @post.comments.find_by(id: params[:id])
			redirect_to post_path(@post) unless @comment
			if @post.user != current_user
        check_user
      end
		end

		def check_user
			@comment = @post.comments.find_by(id: params[:id])
			redirect_to post_path(@post) unless @comment
      if @comment.user != current_user
        redirect_to @post, notice: "Cannot access other user comment page"
      end
    end

		def find_all_child_comment comments
			comments.each do |comment|
				@comment_ids.push(comment.id)
				if(comment.children)
					find_all_child_comment(comment.children)
				end
			end
		end

    def calculate_left_margin(comment)
      if comment
        left_margin = 100
        level = comment.level
        while level >= 0
          left_margin *= 0.9
          level = level - 1
        end
        left_margin
      else
        left_margin = 0
      end
    end

    def set_no_of_children(parent_comment)
      no_of_children = 0
      if parent_comment
        no_of_children = parent_comment.children.length
      end
      no_of_children
    end
end
