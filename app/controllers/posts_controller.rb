class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
  end

  def new
  end

  def create
    @post = Post.new(post_params)   #to keep params if error happens
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end
  
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    def set_post
      if Post.exists?(params[:id])
        @post = Post.find_by(id: params[:id])
      else
        flash[:notice] = "No such post found !!"
        redirect_to posts_path
      end
    end

    
    def post_params
      params.require(:post).permit(:title, :user_id)
    end
end
