class ChatNotificationsChannel < ApplicationCable::Channel
  def subscribed
    puts "## SUBSCRIBED notification_#{params['user_email']}"
    stream_from "notification_#{params['user_email']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    puts "## SENT_MESSAGE #{data['chat_room_id']} : #{data['message']}"
    Conversation.find(data['chat_room_id']).messages.create(user: current_user, content: data['message'])
  end
end