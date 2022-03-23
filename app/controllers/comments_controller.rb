class CommentsController < ApplicationController
    before_action :authenticate_user!



    def create
        @post = Post.find(params[:post_id])
        if Comment.create(user_id: current_user.id, post_id: @post.id, body: params[:body])
            params[:body] = ""
        end
    end

    def edit
        @comment = Comments.find(params[:id])
    end

    def update
        @comment = Comments.find(params[:id])
        if @comments.update(comment_params)
            #redirect_to(post_path(@post))
        else
            render('edit')
        end
    end


    def destroy
        if Comment.destroy(params[:id])
            redirect_to posts_path
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body, :user_id, :post_id)
      end

end
