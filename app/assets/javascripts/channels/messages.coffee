#$(document).ready ->
#  console.log "message ws"
#  if $('.messages').length > 0
#    messages = $('.messages')
#    App.global_chat = App.cable.subscriptions.create {
#    channel: "ChatChannel"
#    chat_id: $('.conversation').attr('data')
#    },
#    connected: ->
#  # Called when the subscription is ready for use on the server
#
#    disconnected: ->
#  # Called when the subscription has been terminated by the server
#
#    received: (data) ->
#      console.log "RECEIVED"
#      console.log data['message']
#      messages.append data['message']
#      #messages_to_bottom()
#
#    send_message: (message, chat_room_id) ->
#      @perform 'send_message', message: message, chat_room_id: chat_room_id
#
##    $('#new_message').submit (e) ->
##      e.preventDefault()
##      console.log "тыц"
##      textarea = $(this).find('#message_content')
##      if $.trim(textarea.val()).length > 1
##        console.log $('.conversation').attr('data')
##        App.global_chat.send_message textarea.val(), $('.conversation').attr('data')
##        textarea.val('')
##      console.log "опа"
##      return false
#  $("body").on("submit", ".message_button", (e) ->
#    e.preventDefault()
#    console.log "тыц"
#    textarea = $(this).find('#message_content')
#    if $.trim(textarea.val()).length > 1
#      console.log $('.conversation').attr('data')
#      App.global_chat.send_message textarea.val(), $('.conversation').attr('data')
#      textarea.val('')
#    console.log "опа"
#    return false
#  )