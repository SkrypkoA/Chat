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
#      slider.destroySlider()
      if typeof window.slider != 'undefined'
        window.slider.destroySlider()
      window.slider = $('.bxslider').bxSlider(
        #adaptiveHeight: true
#        slideWidth: 1000
#        responsive: false
        buildPager: (slideIndex) ->
          src = $(".picture##{slideIndex}").attr('src')
          html = "<img src='#{src}' class='pager-picture img-circle'>"
      )
      window.slider.redrawSlider()

#      slider.setPositionProperty(0, 'reset', 0)
      #slider.redrawSlider
#      slider.destroySlider()
#      slider.resizeWindowForc()
      console.log(window.slider)
      $('.dropdown-toggle').dropdown()
      #console.log("done")
    )
    return
  )
  return

