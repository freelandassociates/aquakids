jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

jQuery ->
  # enable chosen js
  $('.chzn-select').chosen
    allow_single_deselect: true
    no_results_text: 'Nothing matches'

jQuery ->
  $('#datatable').dataTable()  
  bJQueryUI: true  

  # $('alert').removeClass('alert').addClass('alert-message error').attr('data-alert', 'alert').append('<a class="close" href="#">x</a>')
  # $('notice').removeClass('notice').addClass('alert-message warning').attr('data-alert', 'alert').append('<a class="close" href="#">x</a>')