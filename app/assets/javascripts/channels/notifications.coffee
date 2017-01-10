getChatPartial = (conversation_id) ->
  $.ajax(
    url: "/conversations/#{conversation_id}/show_partial"
    type: 'GET'
    dataType: 'json').done((json) ->
    $('.mini-chat').append(json.html)
    $('.conversation-messages').scrollTop($('.conversation-messages').prop("scrollHeight"))
    return
  )
  return

$(document).ready ->
  console.log "notification ws"
  if $('.email').length > 0
    email = $('.email')
    App.notify_chat = App.cable.subscriptions.create {
      channel: "ChatNotificationsChannel"
      user_email: $('.email').text().trim()
    },
      connected: ->
# Called when the subscription is ready for use on the server
        console.log "Connected to notification"
      disconnected: ->
# Called when the subscription has been terminated by the server
      received: (data) ->
        console.log "RECEIVED"
        #console.log data['notification']
        #$('.messages').append data['message']
        if $(".conversation[data-conversation = #{data['channel_id']}]").length > 0
          $(".conversation[data-conversation = #{data['channel_id']}]>.conversation-messages").append(data['message'])
          $('.conversation-messages').scrollTop($('.conversation-messages').prop("scrollHeight"))
        else
          $.ajax(
            url: "/conversations/#{data['channel_id']}/show_partial"
            type: 'GET'
            dataType: 'json').done((json) ->
            $('.mini-chat').append(json.html)
            $('.conversation-messages').scrollTop($('.conversation-messages').prop("scrollHeight"))
            return
          )
      send_message: (message, chat_room_id) ->
        console.log "SEND MESSAGE #{chat_room_id}"
        @perform 'send_message', message: message, chat_room_id: chat_room_id

################################################################################
    $("body").on("click", ".message_button", (e) ->
      e.preventDefault()
      console.log "тыц"
      #textarea = $('#message_content')
      textarea = $(this).parents('form:first').find('textarea')
      if $.trim(textarea.val()).length > 0
        console.log $('.conversation').attr('data-conversation')
        App.notify_chat.send_message textarea.val(), $(this).parents('.conversation:first').attr('data-conversation')
        textarea.val('')
      console.log "опа"
      return false
    )
  $("body").on("click", ".hide-chat-btn", (e) ->
    e.preventDefault()
    if $('.user-list').is(":visible")
      $('.user-list').hide('fast')
    else
      $('.user-list').show('fast')
    $('.users').toggleClass('col-md-2 col-md-1');
    $('.body').toggleClass('col-md-11 col-md-10');
    return false
  )
  $("body").on("click", ".link-to-conversation", (e) ->
    e.preventDefault()
    $.ajax(
      url: $(this).attr('href')
      type: 'POST'
      dataType: 'json').done((json) ->
      if $(".conversation[data-conversation = #{json.conversation_id}]").length == 0
        getChatPartial(json.conversation_id)
      return
    )
    return false
  )




