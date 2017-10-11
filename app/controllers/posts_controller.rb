class PostsController < ApplicationController
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_authenticated_user?, only: [:edit, :update, :destroy]

  def index
    if params[:search]
      @posts = Post.search(params[:search]).page params[:page]
    else
      @posts = Post.order("updated_at DESC").page params[:page]
    end
  end

  def show
    @following_count = @post.user.following.count
    @followers_count = @post.user.followers.count
    @post_user = @post.user.name
    @comments = @post.get_root_comments
    @current_user_likes = Comment.get_user_likes(@comments, current_user.id)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully destroyed.'
  end

  def my_blogs
    if params[:search]
      @posts = current_user.posts.search(params[:search]).page params[:page]
    else
      @posts = current_user.posts.order("updated_at DESC").page params[:page]
    end
  end

  private
    def get_post
      @post = Post.find_by(id: params[:id])
      unless @post
        redirect_to posts_path, notice: 'The post you are looking for does not exist'
      end
    end

    def check_authenticated_user?
      if @post.user != current_user
        redirect_to posts_path, notice: "Cannot access other user post page"
      end
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end

