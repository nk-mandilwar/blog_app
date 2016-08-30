class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC").page params[:page]
    else
      @posts = Post.order("created_at DESC").page params[:page]
      # @posts = Post.includes(:user).order("created_at DESC").page params[:page]
    end
  end

  def show
    unless @post 
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.posted_by = current_user.name
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
    @posts = current_user.posts.page params[:page]
    render 'index'
  end

  private
    def set_post
      @post = Post.find_by(:id => params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
