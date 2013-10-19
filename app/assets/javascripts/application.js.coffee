#= require jquery_ujs
#= require page-scroll.min
#= require_self

$ ->
  $('#main.content').onepage_scroll
    afterMove: (index)->
      console.log index
    


