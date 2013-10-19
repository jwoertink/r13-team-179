#= require jquery_ujs
#= require underscore.min
#= require page-scroll.min
#= require_self

$ ->
  $('#main.content').onepage_scroll
    afterMove: (index)->
      if index == 1
        $('nav.hidden-nav').slideDown('slow')
        # slide the new nav down
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


