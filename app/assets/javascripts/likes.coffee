$(document).ready ->
  $("body").on("click", ".like_button", (e) ->
    e.preventDefault()
    $.ajax(
      url: $('.button_to').attr('action')
      #data: comment: content: $('.comment_content').val()
      type: if $("div.likes > section > form > input[name$='_method']").val('delete').length > 0 then 'DELETE' else 'POST'
      dataType: 'json').done((json) ->
      $('.likes_count').html(json.likes_count)
      $('.likes').html(json.html)
      return
    )
  )