class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_params, only: :create

  def index
    @comments = Comment.all.preload(:user, :picture)
  end

  def create
    @comment = current_user.comments.create!(@comment_params)

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { email: current_user.email, comment: @comment.content } }
    end

  end

  private

    def set_params
       @comment_params = params.require(:comment).permit(:content)
       @comment_params[:picture] = Picture.find(params[:picture_id])
    end
end
