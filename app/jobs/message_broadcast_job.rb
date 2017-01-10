class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    message.conversation.users.each do |user|
      ActionCable.server.broadcast "notification_#{user.email}",
                                   message: render_message(message),
                                   channel_id: message.conversation_id
    end
  end

  private

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: {message: message}
  end
end