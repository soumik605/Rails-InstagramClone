class LikesController < ApplicationController
  before_action :check_post_by_postId, only: [:index, :create]
  def index
  end

  def create
    @post = Post.find(params[:post_id])
    if current_user.liked?(@post)
      current_user.unlike(@post)
    else
      current_user.like(@post)
    end
  end


  private

  
  def check_post_by_postId
    if params[:post_id]
      @post = Post.exists?(params[:post_id])
      unless @post
          redirect_to posts_path
          flash[:notice] = "No such post found !"
      end
    end
  end
  
end
