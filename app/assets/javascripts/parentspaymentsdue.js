$(document).ready(function () {

            readOnlyDataSource = new kendo.data.DataSource({
                transport: {
                    read:  {
                        url: "/parents/get_payments_due",
                        dataType: "json"
                    }
                  },
                autoSync: false,
                schema: {
                    model: {
                        id: "id",
                        fields: {
                            select: { type: "string", editable: true },
                            first_name: { editable: false },
                            last_name: { editable: false }
                        }
                    }
                }
            });

            $("#datatable").kendoGrid({
                dataSource: readOnlyDataSource,
                height: 390,
                scrollable: true,
                sortable: true,
                reorderable: true,
                // selectable: "row",
                resizable: true,
                change: function(e) {
                  // To handle clicking on a row in the main grid and reloading the detail grid with registrations..
                },
                dataBound: function(e) {
                  // alert("Data Bound!");
                },
                columns: [
                    {field: "select",           title: " ",             width: 27, sortable: false, template: '<input type=\'checkbox\' class=\'select_one\' onclick=\'checkBoxCount ()\' rel=\'#=id#\' />' },
                    
                    // {field: "checkbox",         title: " ",             width: 27, sortable: false },
                    {field: "first_name",          title: "First Name",       width: 80 },
                    {field: "last_name",          title: "Last Name",       width: 80 }
                    ]
            });


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




