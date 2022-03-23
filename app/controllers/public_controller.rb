class PublicController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :get_users
    before_action :check_user, only: [:account, :friend]

    def index
    end

    def account
        @is_current_user = (params[:user_id].to_i == current_user.id.to_i)
        @user = User.find(params[:user_id])
    end

    def suggestion
    end

    def friend
    end


    private

    def get_users
        @users = User.all
    end

    def check_user
        if params[:user_id]
          @user = User.exists?(params[:user_id])
          unless @user
              redirect_to posts_path
              flash[:notice] = "No such user found !"
          end
        end
      end
    
end
