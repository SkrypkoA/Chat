class ConversationsController < ApplicationController
  def index

  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.preload(:user)
    #@message = Message.new
  end

  def show_partial
    conversation = Conversation.find(params[:id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { html: (render_to_string partial: 'conversations/conversation',locals: { conversation: conversation }, layout: false, formats: [:html]) } }
      #(render_to_string partial: 'conversations/conversation',locals: { conversation: conversation }, layout: false, formats: [:html])
    end
  end

  def create
    #conversation = Conversation.create!(name: current_user.email)
    ## потом передавать массив
    interlocutor = User.find(params[:user_id])

    #ДОБАВИТЬ ЧАТУ ПРИЗНАК ПРИВАТНЫЙ
    conversation = current_user.conversations.joins(:users).where("users.id = #{interlocutor.id}").first ||
        Conversation.new(name: "#{current_user.email} - #{interlocutor.email}")
    unless conversation.persisted?
      puts "######### NEW CONV!!!"
      conversation.save!
      conversation.users << current_user
      conversation.users << interlocutor
    end


    #NotificationsBroadcastJob.perform_later(interlocutor,conversation)

    # if cookies[:conv].nil?
    #   conversations = []
    # else
    #   conversations = JSON.parse(cookies[:conv])
    # end
    # cookies.permanent[:conv] = conversations.push(conversation.id).to_json
    # puts '###### CONV ' + conversation.id.to_s
    respond_to do |format|
      format.html { redirect_to conversation_path(conversation) }
      format.json { render json: { conversation_id: conversation.id } }
    end
  end
end
