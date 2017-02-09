class ChatChannel < ApplicationCable::Channel
  def subscribed
    puts "## SUBSCRIBED conversation_#{params['chat_id']}"
    NotificationsBroadcastJob.perform_later(current_user,Conversation.find(params['chat_id']))
    stream_from "conversation_#{params['chat_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    puts "## SENT_MESSAGE #{data['chat_room_id']} : #{data['message']}"
    Conversation.find(data['chat_room_id']).messages.create(user: current_user, content: data['message'])
  end
end