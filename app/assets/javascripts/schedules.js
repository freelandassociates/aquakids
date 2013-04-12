// if any "chosen" select control changes, submit the search form..
$(function() {
return $('.chzn-select').chosen().change(function() {
return $('#schedule_search').submit();
});
});

$(function() {
return $('#q_start_date_gteq').datepicker({
                                          format: 'yyyy-mm-dd',
                                          autoclose: true
                                          });
});

$(function() {
return $('#q_start_date_gteq').bind('changeDate', function() {
return $('#schedule_search').submit();
});
});

$(function() {
return $('#q_start_date_lteq').datepicker({
                                          format: 'yyyy-mm-dd',
                                          autoclose: true
                                          });
});

$(function() {
return $('#q_start_date_lteq').bind('changeDate', function() {
return $('#schedule_search').submit();
});
});
