getChatPartial = (conversation_id) ->
  $.ajax(
    url: "/conversations/#{conversation_id}/show_partial"
    type: 'GET'
    dataType: 'json').done((json) ->
    $('.mini-chat').append(json.html)
    $(".conversation[data-conversation=#{conversation_id}] .conversation-messages").scrollTop($(".conversation[data-conversation=#{conversation_id}] .conversation-messages").prop("scrollHeight"))
    $('.dropdown-toggle').dropdown()
    return
  )
  return

feelLink = () ->
  expression = /^(ftp|http|https):\/\/[^ "]+$/
  regex = new RegExp(expression)
  html = $('div.conversation-messages  div:last-child').last().html()
  t = $('div.conversation-messages  div:last-child').last().text().replace(',', '').split(' ')

  IsValidImageUrl = (obj) ->
    $ '<img>',
      src: obj.attr('href')
      error: ->
        console.log '#' + obj.attr('href')
        return
      load: ->
        obj.text('')
        obj.append("<img src=' #{obj.attr('href')}'>")
        return

  IsYoutube = (obj) ->
    regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
    match = obj.attr('href').match(regExp)
    if match and match[2].replace('/n','').trim().length == 11
      obj.text('')
      obj.append ('<img class= "youtube" data='+match[2]+' src="//img.youtube.com/vi/'+match[2]+'/0.jpg">');
    return

  jQuery.each t, (i, val) ->
    if val.match(regex)
#console.log val
      html = html.replace(val, '<a href=\'' + val + '\'>' + val + '</a>')
    return
  $('div.conversation-messages div:last-child').last().html html

  $('div.conversation-messages div:last a').each ->
    IsValidImageUrl $(this)
    IsYoutube $(this)
    return
  return

$(document).ready ->
  console.log "notification ws"
  if $('.email').length > 0
    email = $('.email')
    App.cable = ActionCable.createConsumer("/cable")
    App.notify_chat = App.cable.subscriptions.create {
      channel: "ChatNotificationsChannel"
      user_email: $('.email').text().trim()
    },
      connected: ->
      disconnected: ->
      received: (data) ->
        if $(".conversation[data-conversation = #{data['channel_id']}]").length > 0
          $(".conversation[data-conversation = #{data['channel_id']}]>.conversation-messages").append(data['message'])
          $(".conversation[data-conversation=#{data['channel_id']}] .conversation-messages").scrollTop($(".conversation[data-conversation=#{data['channel_id']}] .conversation-messages").prop("scrollHeight"))
        else
          $.ajax(
            url: "/conversations/#{data['channel_id']}/show_partial"
            type: 'GET'
            dataType: 'json').done((json) ->
            $('.mini-chat').append(json.html)
            $(".conversation[data-conversation=#{data['channel_id']}] .conversation-messages").scrollTop($(".conversation[data-conversation=#{data['channel_id']}] .conversation-messages").prop("scrollHeight"))
            return
          )
        feelLink()
      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id

    $("body").on("click", ".message_button", (e) ->
      e.preventDefault()
      textarea = $(this).parents('form:first').find('textarea')
      if $.trim(textarea.val()).length > 0
        App.notify_chat.send_message textarea.val(), $(this).parents('.conversation:first').attr('data-conversation')
        textarea.val('')
      return false
    )
  $("body").on("click", ".hide-chat-btn", (e) ->
    e.preventDefault()
    if $('.user-list').is(":visible")
      $('.user-list').hide('fast')
    else
      $('.user-list').show(10)
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
  $("body").on("click", '.dropup .dropdown-menu', (e) ->
    e.stopPropagation()
    return
  )

  $("body").on('click','.youtube', (e) ->
    e.preventDefault()
    $('.modal-body').html("<iframe class= 'center-block youtube-video' src='//www.youtube.com/embed/" + $(this).attr('data') + "'  allowfullscreen></iframe>")
    $('#myModal').modal 'show'
    return
  )



