#= require jquery_ujs
#= require underscore.min
#= require page-scroll.min
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


