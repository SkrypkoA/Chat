#$(document).ready ->
#  follow_to_chennel = (chennel) ->
##console.log chennel
#    console.log "CONNECTING TO CHAT..."
#    App.global_chat = App.cable.subscriptions.create {
#      channel: "ChatChannel"
#      chat_id: chennel
#    },
#      connected: ->
#        console.log "Connected to message"
## Called when the subscription is ready for use on the server
#      disconnected: ->
#        console.log "Not  connected to message"
## Called when the subscription has been terminated by the server
#      received: (data) ->
#        console.log "RECEIVED"
#        #console.log data['message']
#        $('.messages').append data['message']
##messages_to_bottom()
#      send_message: (message, chat_room_id) ->
#        console.log "SEND MESSAGE"
#        @perform 'send_message', message: message, chat_room_id: chat_room_id
#  #console.log "CONNECTED!"
#  console.log "notification ws"
#  #
#  #    $.ajax(
#  #      url: "/conversations/#{$(this)}/show_partial"
#  #      #data:
#  #      type: 'GET'
#  #      dataType: 'json').done((json) ->
#  ## ВСТАВИТЬ ЧАТИК
#  #      return
#  #    )
#  ################################################################################
#  if $('.email').length > 0
#    email = $('.email')
#    App.notify_chat = App.cable.subscriptions.create {
#      channel: "ChatNotificationsChannel"
#      user_email: $('.email').text().trim()
#    },
#      connected: ->
## Called when the subscription is ready for use on the server
#        console.log "Connected to notification"
#      disconnected: ->
## Called when the subscription has been terminated by the server
#      received: (data) ->
#        console.log "RECEIVED"
#        #console.log data['notification']
#        #if $("#conversation#{data['channel_id']}").length == 0
#        #$("#conversation#{data['channel_id']}").destroy()
#        $('.mini_chat').append data['notification']
#        follow_to_chennel(data['channel_id'])
#        if typeof Cookies.get('conv') != 'undefined'
#          arr = JSON.parse(Cookies.get('conv'))#.split(',')
#        else
#          arr = []
#        if $.inArray(data['channel_id'],arr) == -1
#          arr.push(data['channel_id'])
#          Cookies.set('conv', JSON.stringify(arr));
#    ################################################################################
#    if typeof Cookies.get('conv') != 'undefined'
#      arr = JSON.parse(Cookies.get('conv'))#.split(',')
#      $.each( arr, (i)->
#        console.log arr[i]
#        follow_to_chennel(arr[i])
#      )
#    ################################################################################
#    $("body").on("click", ".message_button", (e) ->
#      e.preventDefault()
#      console.log "тыц"
#      #textarea = $('#message_content')
#      textarea = $(this).parents('form:first').find('textarea')
#      if $.trim(textarea.val()).length > 1
#        console.log $('.conversation').attr('data')
#        App.global_chat.send_message textarea.val(), $('.conversation').attr('data')
#        textarea.val('')
#      console.log "опа"
#      return false
#    )
##    $("body").on("click", ".message_button", (e) ->
##
##    )
#
