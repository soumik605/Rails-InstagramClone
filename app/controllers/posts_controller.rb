class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_all_posts

  def index
    @users_except_current = User.all_except(current_user.id)


  end

  def show
    post = Post.find(params[:id])
    s = current_user.liked?(post)
    puts(s)
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
      render json: { errors: @post.errors }, status: :unprocessable_entity
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

  def like
    @post = Post.find(params[:id])

    if current_user.liked?(@post)
      current_user.unlike(@post)
    else
      current_user.like(@post)
    end
      redirect_to posts_path
  end


    def addcomment
      @post = Post.find(params[:id])
      if Comment.create(user_id: current_user.id, post_id: @post.id, body: params[:body])
        params[:body] = ""
        redirect_to posts_path
      end
    end

    def deletecomment
      if Comment.destroy(params[:id])
        redirect_to posts_path
      end
    end

  private

  def post_params
    params.require(:post).permit(:title, :image, :total_likes)
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

  def fetch_all_posts
    @posts = Post.all
  end

end
