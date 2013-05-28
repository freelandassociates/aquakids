$(document).ready(function () {

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
    // alert($("input:checkbox:checked").length);
    var relArr="";
    $("input:checkbox.select_one:checked").each(function(){
        // relArr.push($(this).attr('rel'));
        relArr = relArr.concat("schedule_ids[]=",$(this).attr('rel'),"&");
    });
    relArr = relArr.replace(/&$/,"");
    alert(relArr);
    $.get('/copyclasses/copy_classes?' + relArr );
}
