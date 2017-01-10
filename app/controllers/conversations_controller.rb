class ConversationsController < ApplicationController
  def index

  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.preload(:user)
  end

  def show_partial
    conversation = Conversation.find(params[:id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { html: (render_to_string partial: 'conversations/conversation',locals: { conversation: conversation }, layout: false, formats: [:html]) } }
    end
  end

  def create
    ## потом передавать массив
    interlocutor = User.find(params[:user_id])

    #ДОБАВИТЬ ЧАТУ ПРИЗНАК ПРИВАТНЫЙ
    conversation = current_user.conversations.joins(:users).where("users.id = #{interlocutor.id}").first ||
        Conversation.new(name: "#{current_user.email} - #{interlocutor.email}")
    unless conversation.persisted?
      conversation.save!
      conversation.users << current_user
      conversation.users << interlocutor
    end

    respond_to do |format|
      format.html do
        redirect_to conversation_path(conversation)

      end
      format.json do
        render json: { conversation_id: conversation.id }
      end
    end
  end
end
