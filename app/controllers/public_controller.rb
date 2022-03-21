class PublicController < ApplicationController
    before_action :authenticate_user!, except: [:index]

    def index
    end

    def account
        @is_current_user = (params[:user_id].to_i == current_user.id.to_i)
        @user = User.find(params[:user_id])


    end
    
end
