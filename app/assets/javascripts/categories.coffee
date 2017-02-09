# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
#$('.bxslider').bxSlider pagerCustom: '#bx-pager'
#  $('.bxslider').bxSlider
#    adaptiveHeight: true
#    buildPager: (slideIndex) ->
#    #return $(".picture##{slideIndex}").html()
#      src = $(".picture##{slideIndex}").attr('src')
#      html = "<img src='#{src}' class='pager-picture'>"

  $("body").on('click','.category', (e) ->
    e.preventDefault()
    href = $(this).attr('href')
    console.log href
    #console.log "<iframe class= 'center-block' src='//localhost:3000#{href}'  allowfullscreen></iframe>"
    $.ajax(
      url: $(this).attr('href')
#data: comment: content: $('.comment_content').val()
      type: 'GET'
      dataType: 'json').done((json) ->
      $('.modal-body').html(json.html)
      $('#myModal').modal 'show'
      $('.bxslider').bxSlider(
        #adaptiveHeight: true
        buildPager: (slideIndex) ->
          src = $(".picture##{slideIndex}").attr('src')
          html = "<img src='#{src}' class='pager-picture img-circle'>"
      )
      $('.dropdown-toggle').dropdown()
    )
    return
  )
  return

