#= require jquery_ujs
#= require underscore.min
#= require page-scroll.min
#= require scriptcam
#= require reveal
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
  $('a.ready-cam').click ->
    $('.webcam-box .preload').remove()
    readyWebcam()
    false
  $('.start-video').click ->
    $('.overlay-start').remove()
    loadNextQuestion()
    false
  
$.timer = null
$.progress = null
$.delay = (ms, func) -> window.setTimeout func, ms
$.loop = (ms, func) -> window.setInterval func, ms

$.questionCount = 0
readyWebcam = ()->
  $("#webcam").scriptcam
    width: 640
    height: 480
    onError: (errorID, msg)->
      console.log "Error: #{errorID}"
      console.log msg
    fileName: 'question_1' # TODO: figure out which question I'm on
    connected: ()->
      console.log 'connected to server'
      $('#webcamModal').animate {'opacity', '0.3'}, 'slow', ()->
        $('#main').css('z-index', '102')
        $('.overlay-start').removeClass('hidden')
    maximumTime: 20
    country: 'usa'
          
      
startRecording = (currentQuestion)->
  window.clearInterval($.timer) if $.timer
  $('#webcamModal .progress .bar').css('width', "0%")
  # $.scriptcam.startRecording()
  $counter = 0
  $.timer = $.loop 1000, ()=>
    $counter += 1
    console.log "#{$counter} seconds passed"
    $('#webcamModal .progress .bar').css('width', "#{20 * $counter}%")
    if $counter >= 5
      console.log 'camera paused'
      # $.scriptcam.pauseRecording();
      if $.questionCount >= 4
        loadFinalForm()
      else
        loadNextQuestion()
        $('#webcamModal').animate {'opacity', '0.3'}, 'slow', ()->
          $('#main').css('z-index', '102')
      window.clearInterval($.timer)
  
loadNextQuestion = ()->
  $.questionCount += 1
  $overlay = $(".overlay-question[data-question=#{$.questionCount}]")
  $overlay.removeClass('hidden')
  $('.answer.action', $overlay).click ->
    $(@).replaceWith('<span class="counter">3</span>')
    $.delay 1000, -> 
      $('span.counter', $overlay).text('2')
      $.delay 1000, -> 
        $('span.counter', $overlay).text('1')
    $('#webcamModal').animate({'opacity': 1}, 'slow')
    $('#main').css('z-index', '100')
    $overlay.hide()
    startRecording($.questionCount)
    false
    
loadFinalForm = ()->
  $('.overlay-complete').removeClass('hidden')
  