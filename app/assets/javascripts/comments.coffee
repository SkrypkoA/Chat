$(document).ready ->
  #$( '.comment_button' ).click (e) ->
  $( ".comment > input[type='submit']").click (e) ->
    e.preventDefault()
    console.log "comm js"
    $(this).attr 'disabled', 'disabled'
    $.ajax(
      url: $('#new_comment').attr('action')
      data: comment: content: $('.comment_content').val()
      type: 'POST'
      dataType: 'json').done((json) ->
        $('.comments').append '<li> ' + json.email + ': ' + json.comment + ' </li>'
        $('.comment_content').val('')
        return
    ).always (xhr, status) ->
    enable_button = ->
      $( '.comment_button' ).removeAttr('disabled')
      return
    setTimeout(enable_button, 5000)
    return