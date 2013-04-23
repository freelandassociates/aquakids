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


// $(document).ready(function () {
//     var crudServiceBaseUrl = "/schedules",
//         dataSource = new kendo.data.DataSource({
//             transport: {
//                 read:  {
//                     url: crudServiceBaseUrl,
//                     dataType: "json"
//                 },
//                 update: {
//                     url: function(expense) {
//                         return crudServiceBaseUrl + "/" + schedule.id;
//                     },
//                     dataType: "json",
//                     contentType: "application/json",
//                     type: "PUT"
//                 },
//                 destroy: {
//                     url: function(expense) {
//                         return crudServiceBaseUrl + "/" + schedule.id
//                     },
//                     dataType: "json",
//                     type: "DELETE"
//                 },
//                 create: {
//                     url: crudServiceBaseUrl,
//                     dataType: "json",
//                     contentType: "application/json",
//                     type: "POST"
//                 },
//                 parameterMap: function(schedule, type) {
//                     if (type === "create" || type === "update") {
//                         return JSON.stringify({ schedule: schedule });
//                     }
//                 }
//             },
//             pageSize: 30,
//             schema: {
//                 model: {
//                     id: "id",
//                     fields: {
//                         location: { editable: true },
//                         facility: { type: "number", validation: { required: true } }
//                     }
//                 }
//             }
//         });

//     $("#grid").kendoGrid({
//         dataSource: dataSource,
//         navigatable: true,
//         pageable: true,
//         height: 400,
//         toolbar: ["create", "save", "cancel"],
//         columns: [
//             { field: "location_id", width: "150px" },
//             { field: "facility", format: "{0:c}", width: "150px" },
//             { command: "destroy", title: " ", width: "110px" }],
//         editable: true
//     });
// });