class LikesController < ApplicationController
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
  
end
