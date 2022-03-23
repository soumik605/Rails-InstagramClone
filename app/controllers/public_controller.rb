class PublicController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :get_users

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
    
end
