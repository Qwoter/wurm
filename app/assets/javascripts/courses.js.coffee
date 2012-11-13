# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$("#catalog tr").draggable
    appendTo: "body"
    helper: "clone"

  $("#courses ol").droppable(
    activeClass: "ui-state-default"
    hoverClass: "ui-state-hover"
    accept: ":not(.ui-sortable-helper)"
    drop: (event, ui) ->
      $(this).find(".placeholder").remove()
      $("<li></li>").text(ui.draggable.text()).appendTo this
  ).sortable
    items: "li:not(.placeholder)"
    sort: ->
      
      # gets added unintentionally by droppable interacting with sortable
      # using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
      $(this).removeClass "ui-state-default"