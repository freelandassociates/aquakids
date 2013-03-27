jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  # $('alert').removeClass('alert').addClass('alert-message error').attr('data-alert', 'alert').append('<a class="close" href="#">x</a>')
  # $('notice').removeClass('notice').addClass('alert-message warning').attr('data-alert', 'alert').append('<a class="close" href="#">x</a>')