//$(function() {
//  $("a[rel=popover]").popover();
//  $(".tooltip").tooltip();
//  return $("a[rel=tooltip]").tooltip();
//});

$(function() {
    return $('.chzn-select').chosen({
                                allow_single_deselect: true,
                                no_results_text: 'Nothing matches'
                                });
});

//$(function() {
//    return $('#datatable').dataTable({
//                                 "sDom": "<'row'<'span6'l><'span6'f>r>t<'row'<'span6'i><'span6'p>>",
//                                 "sPaginationType": "bootstrap"
//                                 });
//});

$(document).ready( function () {
    $('#datatable').dataTable( {
        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "sSwfPath": "/TableTools/swf/copy_csv_xls_pdf.swf"
        }
    } );
} );