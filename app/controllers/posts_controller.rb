class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_all_posts_and_users
  before_action :check_post_by_Id, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      render :show
    else
      #render json: { errors: @post.errors }, status: :unprocessable_entity
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to(post_path(@post))
    else
      render('edit')
    end
  end

  def destroy
    Post.destroy(params[:id])
  end

  

  private

  def post_params
    params.require(:post).permit(:title, :image, :total_likes)
  end

  def fetch_all_posts_and_users
    @posts = Post.all
    @users = User.all
  end

  def check_post_by_Id
    if params[:id]
      @post = Post.exists?(params[:id])
      unless @post
          redirect_to posts_path
          flash[:notice] = "No such post found !"
      end
    end
  end


end
