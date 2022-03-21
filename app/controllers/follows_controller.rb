class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :not_current_user

  def create
    puts(params)
    user = User.find(params[:id])
    current_user.follow(user)
  end

  def destroy
    puts("unfollowing...")
  end


  private

  def not_current_user
    params[:user_id] != current_user.id
  end
end
