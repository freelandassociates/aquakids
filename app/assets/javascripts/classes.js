$(document).ready(function () {

// function traceDate(msg, obj) {
//     $("#flash-messages").append(msg + " : " + obj + "\n");
// }

// var date = new Date(2012, 8, 26, 12, 34, 56, 789);
// var iso = JSON.stringify(date).replace(/"/g, '');
// traceDate("Original date ", date);
// traceDate("date as ISO8601 ", iso);
// traceDate("kendo.parseDate ", kendo.parseDate(iso, "yyyy-MM-ddTHH:mm:ss.fffZ"));



    var checked = false;
    var firstTh = $( 'th.k-header:first');
    firstTh.append('<input id="selectall" class="selectAll" type="checkbox" />').click (function (event) {
            if (checked)
                {
                    $(":checkbox").prop("checked", false);
                    checked = false;
                    document.getElementById("copyclass").disabled=true;
                    document.getElementById("deleteclass").disabled=true;
                }
            else
                {
                    $(":checkbox").prop("checked", true);
                    checked = true;
                    document.getElementById("copyclass").disabled=false;
                    document.getElementById("deleteclass").disabled=false;
                }
        });

});

// Every time a checkbox is clicked, count the number of checked boxes and enable
// or disable the CopyClass button accordingly..
function checkBoxCount() {
    // alert($("input:checkbox:checked").length);
    if ($("input:checkbox:checked").length > 0)
        {
            document.getElementById("copyclass").disabled=false;
            document.getElementById("deleteclass").disabled=false;
        }
    else
        {
            document.getElementById("copyclass").disabled=true;
            document.getElementById("deleteclass").disabled=true;
        }
}

function submit_copyclass() {
    var relArr="";
    $("input:checkbox.select_one:checked").each(function(){
        relArr = relArr.concat("schedule_ids[]=",$(this).attr('rel'),"&");
    });
    relArr = relArr.replace(/&$/,"");
    window.location.href = ('/copyclasses/copy_classes?' + relArr );
}

function submit_delete_many() {
    var relArr="";
    $("input:checkbox.select_one:checked").each(function(){
        relArr = relArr.concat("schedule_ids[]=",$(this).attr('rel'),"&");
    });
    relArr = relArr.replace(/&$/,"");
    $.post('/schedules/delete_many?' + relArr );
    var qsrl = $("#schedule_search").serialize();
    $("#datatable").data("kendoGrid").dataSource.read(qsrl);
}
