module Admin
  class CommentsController < ApplicationController
    def index
      @comments = Comment.all
    end

    def show
      @comment = Comment.find(params[:id])
    end

    def new
      @comment = Comment.new
    end

    def destroy
      @comment = Comment.find(params[:id])

      @comment.destroy
      flash[:success] = 'Comment deleted'
      redirect_to admin_comments_path
    end

    private

    def comment_params
      params.require(:comment).permit(:text)
    end
  end
end
