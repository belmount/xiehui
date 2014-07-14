# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.
$(document).ready ->
  $('.student-score').on 'ajax:success', (e,data, status, xhr)->
    $(this).find(".alert").addClass('alert-warning').html('<i class="fa fa-check-square"></i>')
