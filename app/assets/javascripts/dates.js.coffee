$ -> 
  $("input.datepicker").each (i) ->
  	$(this).datepicker
  		showOn: "button"
  		buttonImage: "calendaricon.png"
  		buttonImageOnly: true
  		altFormat: "yy-mm-dd"
  		dateFormat: "mm/dd/yy"
  		altField: $(this).next()

  $(".ui-datepicker-trigger").css("float","left")
  $(".ui-datepicker-trigger").css("height", "28px")
  $(".ui-datepicker-trigger").css("position", "relative")
  $(".ui-datepicker-trigger").css("top", "1px")
  $(".ui-datepicker-trigger").css("right", "27px")