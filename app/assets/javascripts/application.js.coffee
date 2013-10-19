#= require jquery_ujs
#= require underscore.min
#= require page-scroll.min
#= require scriptcam
#= require_self

$ ->
  $('#main.content').onepage_scroll
    afterMove: (index)->
      currentPage = $('.onepage-pagination a.active').data('index')
      if currentPage != 1
        $('nav.hidden-nav').slideDown('fast')
      else
        $('nav.hidden-nav').slideUp('fast')
  $('.action.scroll').click ->
    nextPage = parseInt($(@).data('page'))
    currentPage = $('.onepage-pagination a.active').data('index')
    if nextPage < currentPage
      $('#main.content').moveUp()
    else if nextPage > currentPage
      _(nextPage - currentPage).times ->
        $('#main.content').moveDown()
    else
      # do nothing
    false
  readyWebcam()
  $('a.ready-cam').click ->
    $('.webcam-box .preload').html('')
    $('.overlay-start').removeClass('hidden')
    $('#webcam').css({'opacity': 1})
    false
  
$.timer = null
$.progress = null
$.delay = (ms, func) -> window.setTimeout func, ms
$.loop = (ms, func) -> window.setInterval func, ms
  
readyWebcam = ()->
  $("#webcam").scriptcam
    width: 960
    height: 640
    onError: (errorID, msg)->
      console.log "Error: #{errorID}"
      console.log msg
    fileName: 'question_1' # TODO: figure out which question I'm on
    connected: ()->
      console.log 'connected to server'
      $('.start-video').click ->
        $('.overlay-start').html('')
        $('.overlay-question[data-question=1]').removeClass('hidden')
        startRecording()
        false
    maximumTime: 20
    country: 'usa'
          
      
startRecording = ()->
  # $.scriptcam.startRecording()
  window.clearInterval($.timer) if $.timer
  $counter = 0
  $.timer = $.loop 1000, ()=>
    $counter += 1
    console.log "#{$counter} seconds passed"
    if $counter >= 5
      console.log 'camera paused'
      # $.scriptcam.pauseRecording();
      window.clearInterval($.timer)

