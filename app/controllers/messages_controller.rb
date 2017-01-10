class MessagesController < ApplicationController

  def index
    @messages = Message.all.preload(:user)
    @message = Message.new
    @users = User.all
  end

  # def create
  #   current_user.post_message!(params[:message][:content])
  #   redirect_to :back
  # end

end