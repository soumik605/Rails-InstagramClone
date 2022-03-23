class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_post_by_postId
    before_action :check_comment_by_Id, only: [:edit, :update, :destroy]



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

      def check_post_by_postId
        if params[:post_id]
            @post = Post.exists?(params[:id])
            unless @post
                redirect_to posts_path
                flash[:notice] = "No such post found !"
            end
          end
      end

      def check_comment_by_Id
        if params[:id]
            @comment = Comment.exists?(params[:id])
            unless @comment
                redirect_to posts_path
                flash[:notice] = "No such comment found !"
            end
          end
      end

end
