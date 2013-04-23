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

$(document).ready(function() {
    $("#datatable").kendoGrid({
        height: 390,
        scrollable: true,
        sortable: true,
        reorderable: true,
        selectable: "row",
        resizable: true,
        columns: [
            {field: "checkbox",      width: 27, sortable: false },
            {field: "location",      width: 120 },
            {field: "facility",      width: 150 },
            {field: "zone",      width: 70 },
            {field: "session",      width: 120 },
            {field: "startdate",      width: 100 },
            {field: "stopdate",      width: 100 },
            {field: "lessons",      width: 100 },
            {field: "starttime",      width: 95 },
            {field: "stoptime",      width: 95 },
            {field: "size",      width: 60 },
            {field: "number",      width: 60 },
            {field: "level",      width: 100 },
            {field: "absences",      width: 100 },
            {field: "specials",      width: 100 },
            {field: "type",      width: 120 },
            {field: "teacher",      width: 120 },
            {field: "comments",      width: 150 },
            {field: "class",      width: 70 },
            {field: "activity",      width: 150 }
            ]
    });



    // Toggle all check boxes on and off..
    var checked = false;   
    $('#selectall').click(function() {
        if (checked) 
            {
                $(":checkbox").prop("checked", false);
                checked = false; 
            }
        else
            {
                $(":checkbox").prop("checked", true);
                checked = true; 
            }       
    });

    // Every time a checkbox is clicked, count the number of checked boxes and enable
    // or disable the CopyClass button accordingly..
    $(":checkbox").click(function() {
        if ($("input:checkbox:checked").length > 0) 
            {
                document.getElementById("copyclass").disabled=false; 
            }
        else
            {
                document.getElementById("copyclass").disabled=true;
            }
    });
    
});





// $(function() {
//     return $('#selectall').onclick(function() {
//         alert("Boo!")
//         $(":checkbox").prop("checked", true);        
//     });
// });


