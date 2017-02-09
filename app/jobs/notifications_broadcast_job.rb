class NotificationsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(user, conversation)
    puts "##### NOTIFY notification_#{user.email}"

    ActionCable.server.broadcast "notification_#{user.email}",
                                 notification: render_notification(conversation),
                                 channel_id: conversation.id

  end

  private

  def render_notification(conversation)
    #MessagesController.render partial: 'layouts/notification', locals: {conversation: conversation}
    MessagesController.render partial: 'conversations/conversation', locals: {conversation: conversation}
  end
end
