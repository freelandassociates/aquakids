// if any "chosen" select control changes, submit the search form..
$(function() {
    return $('.chzn-select').chosen().change(function() {
        var qsrl = $("#schedule_search").serialize();
        $("#datatable").data("kendoGrid").dataSource.read(qsrl);
    });
});

// $(function() {
//     return $('#q_start_date_gteq').datepicker({
//                                           format: 'yyyy-mm-dd',
//                                           autoclose: true
//                                           });
// });

$(function() {
	return $('#q_start_date_gteq').kendoDatePicker({
        format: "yyyy-MM-dd"
    });
});

$(function() {
	return $('#q_start_date_gteq').bind('change', function() {
        var qsrl = $("#schedule_search").serialize();
        $("#datatable").data("kendoGrid").dataSource.read(qsrl);
    });
});

$(function() {
	return $('#q_start_date_lteq').kendoDatePicker({
        format: "yyyy-MM-dd"
    });
});

$(function() {
	return $('#q_start_date_lteq').bind('change', function() {
        var qsrl = $("#schedule_search").serialize();
        $("#datatable").data("kendoGrid").dataSource.read(qsrl);
    });
});


$(function() {
    return $('#q_start_time_gteq').kendoTimePicker({});
});

$(function() {
    return $('#q_start_time_gteq').bind('change', function() {
        var qsrl = $("#schedule_search").serialize();
        $("#datatable").data("kendoGrid").dataSource.read(qsrl);
    });
});

$(function() {
    return $('#q_stop_time_lteq').kendoTimePicker({});
});

$(function() {
    return $('#q_stop_time_lteq').bind('change', function() {
        var qsrl = $("#schedule_search").serialize();
        $("#datatable").data("kendoGrid").dataSource.read(qsrl);
    });
});

// Declare arrays to hold the lookup information.
var levels = [];
var activities = [];
var programs = [];
var facilities = [];
var types = [];
var locations = [];
var zones = [];
var teachers = [];

// Load the lookup arrays from the database.
$.getJSON("/levels.json",       function(data)  { levels = data; });
$.getJSON("/activities.json",   function(data)  { activities = data; });
$.getJSON("/programs.json",     function(data)  { programs = data; });
$.getJSON("/facilities.json",   function(data)  { facilities = data; });
$.getJSON("/types.json",        function(data)  { types = data; });
$.getJSON("/locations.json",    function(data)  { locations = data; });
$.getJSON("/zones.json",        function(data)  { zones = data; });
$.getJSON("/teachers.json",     function(data)  { teachers = data; });


$(document).ready(function () {

        var qsrl = $("#schedule_search").serialize();
        var crudServiceBaseUrl = "/schedules",
            dataSource = new kendo.data.DataSource({
                transport: {
                    read:  {
                        url: function(schedule) {
                            if (window.location.href.indexOf("classes") !== -1) {
                                return crudServiceBaseUrl + "/ransack_search?" + $("#schedule_search").serialize();
                            } else {
                                return crudServiceBaseUrl + "/ransack_read_only_search?" + $("#schedule_search").serialize();
                            }
                        },
                        dataType: "json"
                    },
                    update: {
                        url: function(schedule) {
                            return crudServiceBaseUrl + "/" + schedule.id;
                        },
                        dataType: "json",
                        contentType: "application/json",
                        type: "PUT"
                    },
                    destroy: {
                        url: function(schedule) {
                            return crudServiceBaseUrl + "/" + schedule.id
                        },
                        dataType: "json",
                        type: "DELETE"
                    },
                    create: {
                        url: crudServiceBaseUrl,
                        dataType: "json",
                        contentType: "application/json",
                        type: "POST"
                    },
                    parameterMap: function(schedule, type) {
                        if (type === "create" || type === "update") {
                            return JSON.stringify({ schedule: schedule });
                        }
                    }
                },
                autoSync: true,
                schema: {
                    parse:function (response) {
                        $.each(response, function (idx, elem) {
                            if (elem.start_time && typeof elem.start_time === "string") {
                                elem.start_time = kendo.parseDate(elem.start_time, "yyyy-MM-ddTHH:mm:ssZ");
                            }
                            if (elem.stop_time && typeof elem.stop_time === "string") {
                                elem.stop_time = kendo.parseDate(elem.stop_time, "yyyy-MM-ddTHH:mm:ssZ");
                            }
                        });
                        return response;
                    },
                    model: {
                        id: "id",
                        fields: {
                            checkbox: { editable: false },
                            program_id: { field: "program_id", defaultValue: 1 },
                            start_date: { editable: true },
                            stop_date: { editable: true },
                            lessons: { editable: false },
                            start_time: { editable: true },
                            stop_time: { editable: true },
                            size: { editable: true },
                            sunday: { editable: true },
                            monday: { editable: true },
                            tuesday: { editable: true },
                            wednesday: { editable: true },
                            thursday: { editable: true },
                            friday: { editable: true },
                            saturday: { editable: true },
                            number: { editable: false },
                            level_id: { field: "level_id", defaultValue: 1 },
                            absences: { editable: false },
                            specials: { editable: false },
                            type_id: { field: "type_id", defaultValue: 1 },
                            teacher_id: { field: "teacher_id", defaultValue: 1 },
                            zone_id: { field: "zone_id", defaultValue: 1 },
                            comments: { editable: true },
                            id: { editable: false },
                            activity_id: { field: "activity_id", defaultValue: 1 },
                            location_id: { field: "location_id", defaultValue: 1 },
                            facility_id: { field: "facility_id", defaultValue: 1 }
                        }
                    }
                }
            });

        if (window.location.href.indexOf("classes") !== -1) {
            // alert('Editable classes');
            $("#datatable").kendoGrid({
                dataSource: dataSource,
                height: 390,
                scrollable: true,
                sortable: true,
                reorderable: true,
                resizable: true,
                editable: true,
                columns: [
                    // { command: ["edit", "destroy"], title: "&nbsp;", width: "172px" },
                    { command: ["destroy"], title: "&nbsp;", width: "75px" },
                    // {field: "checkbox",         title: " ",             width: 27, sortable: false },
                    {field: "program_id",       title: "Session",       width: 105, editor: programDropDownEditor, template: "#=getProgramName(program_id)#" },
                    {field: "start_date",       title: "Start Date",    format:"{0:yyyy-mm-dd}", width: 90, editor: dateEditor },
                    {field: "stop_date",        title: "Stop Date",     format:"{0:yyyy-mm-dd}", width: 90, editor: dateEditor },
                    // {field: "lessons",          title: "Lessons",       width: 100 },
                    {field: "start_time",       title: "Start Time",    format:"{0:hh:mm tt}",   width: 90, editor: timeTurner },
                    {field: "stop_time",        title: "Stop Time",     format:"{0:hh:mm tt}",   width: 90, editor: timeTurner },
                    {field: "size",             title: "Size",          width: 50 },
                    {field: "sunday",             title: "Su",          width: 28, template  :"<input type='checkbox' name='selected' checked='checked' />", attributes:{ class:"ob-fld-boolean" } },
                    {field: "sunday",             title: "Mo",          width: 28, template  :"<input type='checkbox' name='selected' checked='checked' />", attributes:{ class:"ob-fld-boolean" } },
                    {field: "sunday",             title: "Tu",          width: 28, template  :"<input type='checkbox' name='selected' checked='checked' />", attributes:{ class:"ob-fld-boolean" } },
                    {field: "sunday",             title: "We",          width: 28, template  :"<input type='checkbox' name='selected' checked='checked' />", attributes:{ class:"ob-fld-boolean" } },
                    {field: "sunday",             title: "Th",          width: 28, template  :"<input type='checkbox' name='selected' checked='checked' />", attributes:{ class:"ob-fld-boolean" } },
                    {field: "sunday",             title: "Fr",          width: 28, template  :"<input type='checkbox' name='selected' checked='checked' />", attributes:{ class:"ob-fld-boolean" } },
                    {field: "sunday",             title: "Sa",          width: 28, template  :"<input type='checkbox' name='selected' checked='checked' />", attributes:{ class:"ob-fld-boolean" } },
                    // {field: "sunday",             title: "Su",          width: 28 },
                    // {field: "monday",             title: "Mo",          width: 28 },
                    // {field: "tuesday",             title: "Tu",          width: 28 },
                    // {field: "wednesday",             title: "We",          width: 28 },
                    // {field: "thursday",             title: "Th",          width: 28 },
                    // {field: "friday",             title: "Fr",          width: 28 },
                    // {field: "saturday",             title: "Sa",          width: 28 },
                    // {field: "number",           title: "#",             width: 40 },
                    {field: "level_id",         title: "Level",         width: 90, editor: levelDropDownEditor, template: "#=getLevelName(level_id)#"},
                    // {field: "absences",         title: "Abs",           width: 50 },
                    // {field: "specials",         title: "Spec",          width: 55 },
                    {field: "type_id",          title: "Type",          width: 100, editor: typeDropDownEditor, template: "#=getTypeName(type_id)#" },
                    {field: "teacher_id",       title: "Teacher",       width: 120, editor: teacherDropDownEditor, template: "#=getTeacherName(teacher_id)#" },
                    {field: "zone_id",          title: "Zone",          width: 60, editor: zoneDropDownEditor, template: "#=getZoneName(zone_id)#" },
                    {field: "comments",         title: "Comments",      width: 150 },
                    {field: "id",               title: "Class#",        width: 70 },
                    {field: "activity_id",      title: "Activity",      width: 130, editor: activityDropDownEditor, template: "#=getActivityName(activity_id)#" },
                    {field: "location_id",      title: "Location",      width: 100, editor: locationDropDownEditor, template: "#=getLocationName(location_id)#" },
                    {field: "facility_id",      title: "Pool",          width: 100, editor: facilityDropDownEditor, template: "#=getFacilityName(facility_id)#" }]
            });
        } else {
            // alert('Read only classes');
            $("#datatable").kendoGrid({
                dataSource: dataSource,
                height: 390,
                scrollable: true,
                sortable: true,
                reorderable: true,
                selectable: "row",
                resizable: true,
                columns: [
                    {field: "checkbox",         title: " ",             width: 27, sortable: false },
                    {field: "program_id",       title: "Session",       width: 105, template: "#=getProgramName(program_id)#" },
                    {field: "start_date",       title: "Start Date",    format:"{0:yyyy-mm-dd}", width: 90 },
                    {field: "stop_date",        title: "Stop Date",     format:"{0:yyyy-mm-dd}", width: 90 },
                    {field: "lessons",          title: "Lessons",       width: 100 },
                    {field: "start_time",       title: "Start Time",    format:"{0:hh:mm tt}",   width: 90 },
                    {field: "stop_time",        title: "Stop Time",     format:"{0:hh:mm tt}",   width: 90 },
                    {field: "size",             title: "Size",          width: 50 },
                    {field: "number",           title: "#",             width: 40 },
                    {field: "level_id",         title: "Level",         width: 90, template: "#=getLevelName(level_id)#" },
                    {field: "absences",         title: "Abs",           width: 50 },
                    {field: "specials",         title: "Spec",          width: 55 },
                    {field: "type_id",          title: "Type",          width: 100, template: "#=getTypeName(type_id)#" },
                    {field: "teacher_id",       title: "Teacher",       width: 120, template: "#=getTeacherName(teacher_id)#" },
                    {field: "zone_id",          title: "Zone",          width: 60, template: "#=getZoneName(zone_id)#"  },
                    {field: "comments",         title: "Comments",      width: 150 },
                    {field: "id",               title: "Class#",        width: 70 },
                    {field: "activity_id",      title: "Activity",      width: 130, template: "#=getActivityName(activity_id)#"  },
                    {field: "location_id",      title: "Location",      width: 100, template: "#=getLocationName(location_id)#"  },
                    {field: "facility_id",      title: "Pool",          width: 100, template: "#=getFacilityName(facility_id)#" }]
            });
        }

        $("#detailtable").kendoGrid({
            dataSource: dataSource,
            height: 120,
            scrollable: true,
            sortable: true,
            reorderable: true,
            resizable: true,
            editable: true,
            columns: [
                {field: "xxxx",         title: "Special",             },
                {field: "xxxx",         title: "S",             },
                {field: "xxxx",         title: "Last",             },
                {field: "xxxx",         title: "First",             },
                {field: "xxxx",         title: "DOB",             },
                {field: "xxxx",         title: "Age",             },
                {field: "xxxx",         title: "Sex",             },
                {field: "xxxx",         title: "P",             },
                {field: "xxxx",         title: "Parent Last",             },
                {field: "xxxx",         title: "Parent First",             },
                {field: "xxxx",         title: "Referral"},
                {field: "xxxx",         title: "Address",             },
                {field: "xxxx",         title: "City",             },
                {field: "xxxx",         title: "State",             },
                {field: "xxxx",         title: "Postal",             },
                {field: "xxxx",         title: "Phone",             },
                {field: "xxxx",         title: "Extension",             },
                {field: "xxxx",         title: "Status",             },
                {field: "xxxx",         title: "Class Cost",             },
                {field: "xxxx",         title: "Entry Date",             },
                {field: "xxxx",         title: "Exit Date",             },
                {field: "xxxx",         title: "Skill",             },
                {field: "xxxx",         title: "Continuance",             },
                {field: "xxxx",         title: "Comments",             },
                {field: "xxxx",         title: "Computer",             },
                {field: "xxxx",         title: "Payment Due Date",             },
                {field: "xxxx",         title: "Reg Date",             },
                {field: "xxxx",         title: "Unit Value",             },
                {field: "xxxx",         title: "User",             },
                {field: "xxxx",         title: "Reg #",             },
                {field: "xxxx",         title: "SSN",             },
                {field: "xxxx",         title: "Cellular",             },
                {field: "xxxx",         title: "Emergency Phone",             },
                {field: "xxxx",         title: "Email",             },
                {field: "xxxx",         title: "Promoted To",             },
                {field: "xxxx",         title: "Reffered By",             },
                {field: "xxxx",         title: "Sales Person",             }]               
        });

});

function dateEditor(container, options) {
    $('<input data-text-field="' + options.field + '" data-value-field="' + options.field + '" data-bind="value:' + options.field + '"data-format="' + options.format + '"/>')
        .appendTo(container)
        .kendoDatePicker({});
}

function timeTurner(container, options) {
    $('<input data-text-field="' + options.field + '" data-value-field="' + options.field + '" data-bind="value:' + options.field + '"data-format="' + options.format + '"/>')
        .appendTo(container)
        .kendoTimePicker({});
}

// Levels 
function getLevelName(level_id_param) {
    for (var idx = 0, length = levels.length; idx < length; idx++) {
      if (levels[idx].level_id === level_id_param) {
        return levels[idx].level_name;
    }
}
}

function levelDropDownEditor(container, options) {
    $('<input required data-text-field="level_name" data-value-field="level_id" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: levels
    });
}

// Activities 
function getActivityName(activity_id_param) {
    for (var idx = 0, length = activities.length; idx < length; idx++) {
      if (activities[idx].activity_id === activity_id_param) {
        return activities[idx].activity_name;
    }
}
}

function activityDropDownEditor(container, options) {
    $('<input required data-text-field="activity_name" data-value-field="activity_id" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: activities
    });
}

// Programs 
function getProgramName(program_id_param) {
    for (var idx = 0, length = programs.length; idx < length; idx++) {
      if (programs[idx].program_id === program_id_param) {
        return programs[idx].program_name;
    }
}
}

function programDropDownEditor(container, options) {
    $('<input required data-text-field="program_name" data-value-field="program_id" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: programs
    });
}

// Facilities 
function getFacilityName(facility_id_param) {
    for (var idx = 0, length = facilities.length; idx < length; idx++) {
      if (facilities[idx].facility_id === facility_id_param) {
        return facilities[idx].facility_name;
    }
}
}

function facilityDropDownEditor(container, options) {
    $('<input required data-text-field="facility_name" data-value-field="facility_id" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: facilities
    });
}

// Types 
function getTypeName(type_id_param) {
    for (var idx = 0, length = types.length; idx < length; idx++) {
      if (types[idx].type_id === type_id_param) {
        return types[idx].type_name;
    }
}
}

function typeDropDownEditor(container, options) {
    $('<input required data-text-field="type_name" data-value-field="type_id" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: types
    });
}

// Teachers 
function getTeacherName(teacher_id_param) {
    for (var idx = 0, length = teachers.length; idx < length; idx++) {
      if (teachers[idx].teacher_id === teacher_id_param) {
        return teachers[idx].teacher_name;
    }
}
}

function teacherDropDownEditor(container, options) {
    $('<input required data-text-field="teacher_name" data-value-field="teacher_id" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: teachers
    });
}

// Zones 
function getZoneName(zone_id_param) {
    for (var idx = 0, length = zones.length; idx < length; idx++) {
      if (zones[idx].zone_id === zone_id_param) {
        return zones[idx].zone_name;
    }
}
}

function zoneDropDownEditor(container, options) {
    $('<input required data-text-field="zone_name" data-value-field="zone_id" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: zones
    });
}

// Locations 
function getLocationName(location_id_param) {
    for (var idx = 0, length = locations.length; idx < length; idx++) {
      if (locations[idx].location_id === location_id_param) {
        return locations[idx].location_name;
    }
}
}

function locationDropDownEditor(container, options) {
    $('<input required data-text-field="location_name" data-value-field="location_id" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: locations
    });
}

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
