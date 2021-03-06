$(function () {
    $(this).on('shown', function() {
      // alert('Shown now...');
      
      $('#registrationModal').css('margin-left',-420);

      // Clear all errors..
      $('.help-inline').remove();
      $('.error').removeClass('error');
      
      // Clear all fields on initial show of modal..

      registration_clear_parent_fields();

      registration_clear_child_fields();

      $("#schedulereg_referral_id").val("");
      $("#schedulereg_referred_by").val("");
      $("#schedulereg_entry_date").val("");
      $("#schedulereg_exit_date").val("");

      // Also reload Parent dropdown with all parents..
      $('#schedulereg_parent_id')
        .find('option')
        .remove();

      $.ajax({url:"parents.json" ,success:function(parents){
        var toAppend = '<option value="">Select parent</option>';
        for(i=0; i<parents.parents.length; i++) {
          toAppend += '<option value="'+ parents.parents[i].id +'">' + parents.parents[i].last_name + ', ' + parents.parents[i].first_name + '</option>';
        }
        $('#schedulereg_parent_id').append(toAppend);
      }});

      // Also reload Child dropdown with all children..
      $('#schedulereg_child_id')
        .find('option')
        .remove();

      // var schedule = $('#schedulereg_current_schedule_id').val();
      // $.ajax({url:"children/childrenForSchedule.json?schedule_id=" + schedule ,success:function(children){
      //   var toAppend = '<option value="">Select child</option>';

      //   for(i=0; i<children.children.length; i++) {
      //     toAppend += '<option value="'+ children.children[i].id +'">' + children.children[i].last_name + ', ' + children.children[i].first_name + '</option>';
      //   }
      //   $('#schedulereg_child_id').append(toAppend);
      // }});

      // Retrieve current schedule_id from hidden field and use to retrieve schedule entry and exit date from schedule table.
      var current_schedule_id = $("#detail_schedule_id").val();
      $("#schedulereg_current_schedule_id").val(current_schedule_id);
      $.ajax({url:"schedules/" + current_schedule_id + ".json",success:function(result){
        var r = result['start_date'].match(/^\s*([0-9]+)\s*-\s*([0-9]+)\s*-\s*([0-9]+)(.*)$/);
        $("#schedulereg_entry_date_user").val(r[2]+"/"+r[3]+"/"+r[1]+r[4]);
        $("#schedulereg_entry_date").val(result['start_date']);
        var r = result['stop_date'].match(/^\s*([0-9]+)\s*-\s*([0-9]+)\s*-\s*([0-9]+)(.*)$/);
        $("#schedulereg_exit_date_user").val(r[2]+"/"+r[3]+"/"+r[1]+r[4]);
        $("#schedulereg_exit_date").val(result['stop_date']);
        $("#schedulereg_location_id").val(result['location_id']);
      }});

      // Also use current_schedule_id to retrieve list of possible payment plans for the correct session (program)..
      // First, remove all payment plans from dropdown..
      $('#schedulereg_payment_plan_id')
        .find('option')
        .remove();

      // Then ajax call and populate dropdown with valid payment plans (plus a "cash" option)..
      console.log(current_schedule_id);
      $.ajax({url:"programs/payment_plansForSchedule.json?schedule_id=" + current_schedule_id ,success:function(payment_plan){
        var toAppend = '<option value="">Cash</option>';
        console.log(payment_plan);
        console.log(payment_plan.programs.length);
        for(i=0; i<payment_plan.programs.length; i++) {
          toAppend += '<option value= "'+ payment_plan.programs[i].id +'">' + payment_plan.programs[i].name + '</option>';
        }
        console.log(toAppend);
        $('#schedulereg_payment_plan_id').append(toAppend);
      }});


    });

    $(this).on('hidden', function() {
      console.log('Hidden or closed...');
      $('#registrationModal').css('margin-left',-9999);

      // $('#new_registration').addClass('disabled');
                    
      
      var fmsg = $.ajax ({
        url: "/scheduleregs/flashrefresh",
        type: "GET",
        complete: function(response, status) {
          // $('#flash-messages').html(response);
          console.log('Status:');
          console.log(status);
          console.log('Response');
          console.log(response.responseText);
          $('#flash-messages').html(response.responseText);
        }
      });



      // Refresh the detail grid...
      $("#detailtable").data("kendoGrid").dataSource.read();

      // Get a reference to the grid
      var grid = $("#datatable").data("kendoGrid");

      // Access the row that is selected
      var select = grid.select();
      // and now the data
      var data = grid.dataItem(select);

      // Ajax call to retrieve the latest version of the schedule record (specifically to retrieve the number of children signed up)
      var childers = $.ajax ({
        url:"schedules/" + $("#detail_schedule_id").val() + ".json",
        type: "GET",
        success: function(response) {
          // Set grid # column to result.number_confirmed for this class..
          data.set("number_confirmed", response['number_confirmed']);
          // grid.refresh();
        }
      });

      var rowIndex = $("#selected_row_index").val();
      console.log("growIndex = ");
      console.log(rowIndex);
      grid.select(rowIndex);

      // grid.select("tr:eq(" + rowIndex + ")");
      

    });

    $(this).bind("ajax:beforeSend", function(evt, xhr, settings){
      console.log('ajax:beforeSend');
    });

    $(this).bind("ajax:success", function(){
      // hide modal window..
      $('#registrationModal').modal('hide');
    });

    $(this).bind("ajax:error", function(evt, xhr, status, error){
      console.log('ajax:error');
      // Remove all previous errors
      $('.help-inline').remove();
      $('.error').removeClass('error');
      httpStatus = $.parseJSON(xhr.status);
      console.log(httpStatus);

      if (httpStatus == 200) {
        $('#cancelButton').click();
      } else {
        errors = $.parseJSON(xhr.responseText);
        console.log(errors);
        for ( error in errors ) {
          $('#schedulereg_' + error).after('<span class="help-inline">' + errors[error] + '</span>');
          $('.schedulereg_' + error).addClass('error');
        }
      }
    });

    $('#schedulereg_child_id').on('change', function() {
      console.log('Child changed..');
      var child = $(this).val();
      if (child == "") {
        // Child drop down has been changed to "" so remove any values from child
        // fields and enable inputs.
        console.log("null child");
        registration_clear_child_fields();

      } else {
        console.log($(this).val());
        // Parent drop down has been changed to a parent, so retrieve values from database and
        // use to populate inputs.  Input protect parent details..
        $.ajax({url:"children/" + child + ".json",success:function(result){
          $("#schedulereg_child_first_name").val(result['first_name']);
          $("#schedulereg_child_first_name").attr('disabled','disabled');
          $("#schedulereg_child_last_name").val(result['last_name']);
          $("#schedulereg_child_last_name").attr('disabled','disabled');
          $("#schedulereg_child_date_of_birth").val(result['date_of_birth']);
          $("#schedulereg_child_date_of_birth").attr('disabled','disabled');
          // here load #schedulereg_child_date_of_birth_user with mm/dd/yyyy date..
          var r = result['date_of_birth'].match(/^\s*([0-9]+)\s*-\s*([0-9]+)\s*-\s*([0-9]+)(.*)$/);
          $("#schedulereg_child_date_of_birth_user").val(r[2]+"/"+r[3]+"/"+r[1]+r[4]);
          $("#schedulereg_child_date_of_birth_user").attr('disabled','disabled');
          $(".ui-datepicker-trigger:first").hide();
          // $("#schedulereg_child_date_of_birth").data('kendoDatePicker').enable(false);
          
          $("#schedulereg_child_notes").val(result['notes']);
          $("#schedulereg_child_notes").attr('disabled','disabled');
          $("#schedulereg_child_sex_male").removeAttr('disabled');
          $("#schedulereg_child_sex_female").removeAttr('disabled');
          // alert(result['sex']);
          if (result['sex'] == "Male") {
            $("#schedulereg_child_sex_male").prop('checked', true);
            $("#schedulereg_child_sex_female").prop('checked', false);
          } else {
            $("#schedulereg_child_sex_female").prop('checked', false);
            $("#schedulereg_child_sex_female").prop('checked', true);
          }
          $("#schedulereg_child_sex_male").attr('disabled','disabled');
          $("#schedulereg_child_sex_female").attr('disabled','disabled');
         
          }});
      }




    });

    $('#schedulereg_parent_id').on('change', function() {
      console.log('Parent changed..');
      var parent = $(this).val();
      if (parent == "") {
        // Parent drop down has been changed to "" so remove any values from parent
        // fields and enable inputs.
        registration_clear_parent_fields();

        // Reload child dropdown here..
        $('#schedulereg_child_id')
          .find('option')
          .remove();
        // // and replace with children of the selected parent.
        // var schedule = $("#schedulereg_current_schedule_id").val();
        // $.ajax({url: "children/childrenForSchedule.json?schedule_id=" + schedule  ,success:function(children){
        //   var toAppend = '<option value="">Select child</option>';
        //   console.log(children.children);
        //   console.log(children.children.length);

        //   for(i=0; i<children.children.length; i++) {
        //     toAppend += '<option value="'+ children.children[i].id +'">' + children.children[i].last_name + ', ' + children.children[i].first_name + '</option>';
        //   }
        //   // console.log(toAppend);
        //   $('#schedulereg_child_id').append(toAppend);
        // }});

      } else {
        console.log($(this).val());
        // Parent drop down has been changed to a parent, so retrieve values from database and
        // use to populate inputs.  Input protect parent details..
        $.ajax({url:"parents/" + parent + ".json",success:function(result){
          $("#schedulereg_parent_first_name").val(result['first_name']);
          $("#schedulereg_parent_first_name").attr('disabled','disabled');
          $("#schedulereg_parent_last_name").val(result['last_name']);
          $("#schedulereg_parent_last_name").attr('disabled','disabled');
          $("#schedulereg_parent_address_1").val(result['address_1']);
          $("#schedulereg_parent_address_1").attr('disabled','disabled');
          $("#schedulereg_parent_address_2").val(result['address_2']);
          $("#schedulereg_parent_address_2").attr('disabled','disabled');
          $("#schedulereg_parent_city").val(result['city']);
          $("#schedulereg_parent_city").attr('disabled','disabled');
          $("#schedulereg_parent_state").val(result['state']);
          $("#schedulereg_parent_state").attr('disabled','disabled');
          $("#schedulereg_parent_zip").val(result['zip']);
          $("#schedulereg_parent_zip").attr('disabled','disabled');
          $("#schedulereg_parent_home_phone").val(result['home_phone']);
          $("#schedulereg_parent_home_phone").attr('disabled','disabled');
          $("#schedulereg_parent_cell_phone").val(result['cell_phone']);
          $("#schedulereg_parent_cell_phone").attr('disabled','disabled');


          // And also blank out and re-enable the child fields...
          registration_clear_child_fields();

          // Reload child dropdown here..
          $('#schedulereg_child_id')
            .find('option')
            .remove();
          // and replace with children of the selected parent.
          $.ajax({url: "children/childrenByParentForSchedule.json?parent_id=" + parent ,success:function(children){
            var toAppend = '<option value="">Select child</option>';
            // console.log(children.children);
            // console.log(children.children.length);

            for(i=0; i<children.children.length; i++) {
              toAppend += '<option value="'+ children.children[i].id +'">' + children.children[i].last_name + ', ' + children.children[i].first_name + '</option>';
            }
            // console.log(toAppend);
            $('#schedulereg_child_id').append(toAppend);
          }});


          }});
      }



    });


  function registration_clear_parent_fields() {
      $("#schedulereg_parent_id").val("");
      $("#schedulereg_parent_first_name").val("");
      $("#schedulereg_parent_first_name").removeAttr('disabled');
      $("#schedulereg_parent_last_name").val("");
      $("#schedulereg_parent_last_name").removeAttr('disabled');
      $("#schedulereg_parent_address_1").val("");
      $("#schedulereg_parent_address_1").removeAttr('disabled');
      $("#schedulereg_parent_address_2").val("");
      $("#schedulereg_parent_address_2").removeAttr('disabled');
      $("#schedulereg_parent_city").val("");
      $("#schedulereg_parent_city").removeAttr('disabled');
      $("#schedulereg_parent_state").val("");
      $("#schedulereg_parent_state").removeAttr('disabled');
      $("#schedulereg_parent_zip").val("");
      $("#schedulereg_parent_zip").removeAttr('disabled');
      $("#schedulereg_parent_home_phone").val("");
      $("#schedulereg_parent_home_phone").removeAttr('disabled');
      $("#schedulereg_parent_cell_phone").val("");
      $("#schedulereg_parent_cell_phone").removeAttr('disabled');


      registration_clear_child_fields();
  }

  function registration_clear_child_fields() {
      $("#schedulereg_child_id").val("");
      $("#schedulereg_child_first_name").val("");
      $("#schedulereg_child_first_name").removeAttr('disabled');
      $("#schedulereg_child_last_name").val("");
      $("#schedulereg_child_last_name").removeAttr('disabled');
      $("#schedulereg_child_date_of_birth").val("");
      $("#schedulereg_child_date_of_birth").removeAttr('disabled');
      $("#schedulereg_child_date_of_birth_user").val("");
      $("#schedulereg_child_date_of_birth_user").removeAttr('disabled');
      $(".ui-datepicker-trigger:first").show();
      // $("#schedulereg_child_date_of_birth").data('kendoDatePicker').enable(true);
      $("#schedulereg_child_sex_male").attr('checked', false);
      $("#schedulereg_child_sex_male").removeAttr('disabled');
      $("#schedulereg_child_sex_female").attr('checked', false);
      $("#schedulereg_child_sex_female").removeAttr('disabled');
      $("#schedulereg_child_notes").val("");
      $("#schedulereg_child_notes").removeAttr('disabled');
  }

});



// if any "chosen" select control changes, submit the search form..
$(function() {
    return $('.chzn-select').chosen().change(function() {
        var qsrl = $("#schedule_search").serialize();
        $("#datatable").data("kendoGrid").dataSource.read(qsrl);
    });
});

// if any input in the search form changes, submit the search form..
$(function() {
    return $("form#schedule_search input").change(function() {
        var qsrl = $("#schedule_search").serialize();
        $("#datatable").data("kendoGrid").dataSource.read(qsrl);
    });
});


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

$(function() {
$('.modal').bind('beforeShow', function(){
      alert('beforeShow!!');
    })
    .show();
});


var detail_schedule_id = 0;
// Declare arrays to hold the lookup information.
var levels = [];
var activities = [];
var programs = [];
var facilities = [];
var types = [];
var locations = [];
var zones = [];
var teachers = [];

var daybooleans = [
  {
    "dayboolean_id" : "",
    "dayboolean_name" : ""
  },
 {
    "dayboolean_id" : false,
    "dayboolean_name" : "No"
  },
  {
    "dayboolean_id" : true,
    "dayboolean_name" : "Yes"
  }
];

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
                            return crudServiceBaseUrl + "/" + schedule.id;
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
                            // Create JSONstarttime from schedule: schedule.start_time...
                            var startHH = schedule['start_time'].getHours();
                            var startMM = schedule['start_time'].getMinutes();
                            var JSONstarttime = new Date(2000,1,1,startHH,startMM,0);
                            // console.log(JSONstarttime);
                            // Create JSONstoptime from schedule: schedule.stop_time...
                            var stopHH = schedule['stop_time'].getHours();
                            var stopMM = schedule['stop_time'].getMinutes();
                            var JSONstoptime = new Date(2000,1,1,stopHH,stopMM,0);
                            // console.log(JSONstoptime);
                            var offsetStartTime = new Date(JSONstarttime.getTime() - JSONstarttime.getTimezoneOffset() * 60 * 1000);
                            console.log(offsetStartTime);
                            var offsetStopTime = new Date(JSONstoptime.getTime() - JSONstoptime.getTimezoneOffset() * 60 * 1000);
                            console.log(offsetStopTime);
                            
                            var JSONstring = JSON.stringify({ schedule: schedule });
                            console.log(JSONstring);
                                                       
                            // overwrite schedule: schedule.start_time with offsetStartTime...
                            schedule['start_time'] = offsetStartTime;
                            // overwrite schedule: schedule.stop_time with offsetStopTime...
                            schedule['stop_time'] = offsetStopTime;
                            var JSONstring = JSON.stringify({ schedule: schedule });
                            console.log(JSONstring);
                            
                            return JSON.stringify({ schedule: schedule });
                        }
                    }
                },
                autoSync: true,
                schema: {
                    parse:function (response) {
                        $.each(response, function (idx, elem) {
                            if (elem.start_time && typeof elem.start_time === "string") {
                                elem.start_time = kendo.parseDate(elem.start_time);
                                var offsetTime = new Date(elem.start_time.getTime() + elem.start_time.getTimezoneOffset() * 60 * 1000);
                                elem.start_time = offsetTime;
                            }
                            if (elem.stop_time && typeof elem.stop_time === "string") {
                                elem.stop_time = kendo.parseDate(elem.stop_time);
                                var offsetTime = new Date(elem.stop_time.getTime() + elem.stop_time.getTimezoneOffset() * 60 * 1000);
                                elem.stop_time = offsetTime;
                            }
                        });
                        return response;
                    },
                    model: {
                        id: "id",
                        fields: {
                            select: { type: "string", editable: false },
                            program_id: { field: "program_id", defaultValue: 1 },
                            start_date: { editable: true, type: "date" },
                            stop_date: { editable: true, type: "date"  },
                            lessons: { editable: false },
                            start_time: { editable: true },
                            stop_time: { editable: true },
                            size: { editable: true },
                            sunday: { editable: true },
                            //sunday: { field: "dayboolean_id", defaultValue: true },
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

            readOnlyDataSource = new kendo.data.DataSource({
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
                            return crudServiceBaseUrl + "/" + schedule.id;
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
                autoSync: false,
                schema: {
                    parse:function (response) {
                        $.each(response, function (idx, elem) {
                            if (elem.start_time && typeof elem.start_time === "string") {
                                elem.start_time = kendo.parseDate(elem.start_time);
                                var offsetTime = new Date(elem.start_time.getTime() + elem.start_time.getTimezoneOffset() * 60 * 1000);
                                elem.start_time = offsetTime;

                            }
                            if (elem.stop_time && typeof elem.stop_time === "string") {
                                elem.stop_time = kendo.parseDate(elem.stop_time);
                                var offsetTime = new Date(elem.stop_time.getTime() + elem.stop_time.getTimezoneOffset() * 60 * 1000);
                                elem.stop_time = offsetTime;
                            }
                        });
                        return response;
                    },
                    model: {
                        id: "id",
                        fields: {
                            select: { type: "string", editable: false },
                            program_id: { field: "program_id", defaultValue: 1 },
                            start_date: { editable: true, type: "date" },
                            stop_date: { editable: true, type: "date" },
                            lessons: { editable: false },
                            start_time: { editable: true },
                            stop_time: { editable: true },
                            size: { editable: true },
                            sunday: { editable: true },
                            //sunday: { field: "dayboolean_id", defaultValue: true },
                            monday: { editable: true },
                            tuesday: { editable: true },
                            wednesday: { editable: true },
                            thursday: { editable: true },
                            friday: { editable: true },
                            saturday: { editable: true },
                            number: { editable: true },
                            number_confirmed: { editable: true },
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

        var detailDataSource = new kendo.data.DataSource ({
                transport: {
                    read:  {
                        url: function(schedule) {
                            return "/scheduleregs/registrations_by_schedule.json?schedule_id=" + $("#detail_schedule_id").val();
                        },
                        dataType: "json"
                    },
                },

                schema: {
                    parse:function (response) {
                        $.each(response, function (idx, elem) {
                            if (elem.registration_date && typeof elem.registration_date === "string") {
                                elem.registration_date = kendo.parseDate(elem.registration_date);
                            }
                        });
                        return response;
                    },
                    model: {
                        id: "id",
                        fields: {
                            child_dob: { type: "date" },
                            entry_date: { type: "date" },
                            exit_date: { type: "date" },
                            payment_due_date: { type: "date" },
                            registration_date: { type: "date" },
                            child_last_name: { editable: false }
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
                    {field: "select",           title: " ",             width: 27, sortable: false, template: '<input type=\'checkbox\' class=\'select_one\' onclick=\'checkBoxCount ()\' rel=\'#=id#\' />' },
                    {field: "program_id",       title: "Session",       width: 105, editor: programDropDownEditor, template: "#=getProgramName(program_id)#" },
                    {field: "start_date",       title: "Start Date",    format:"{0:MM-dd-yyyy}", width: 90, editor: dateEditor },
                    {field: "stop_date",        title: "Stop Date",     format:"{0:MM-dd-yyyy}", width: 90, editor: dateEditor },
                    {field: "start_time",       title: "Start Time",    format:"{0:hh:mm tt}",   width: 90, editor: timeTurner },
                    {field: "stop_time",        title: "Stop Time",     format:"{0:hh:mm tt}",   width: 90, editor: timeTurner },
                    {field: "size",             title: "Size",          width: 50 },
                    {field: "sunday",           title: "Su",            width: 58, editor: daybooleanDropDownEditor, template: "#=getDayBooleanName(sunday)#" },
                    {field: "monday",           title: "Mo",            width: 58, editor: daybooleanDropDownEditor, template: "#=getDayBooleanName(monday)#" },
                    {field: "tuesday",          title: "Tu",            width: 58, editor: daybooleanDropDownEditor, template: "#=getDayBooleanName(tuesday)#" },
                    {field: "wednesday",        title: "We",            width: 58, editor: daybooleanDropDownEditor, template: "#=getDayBooleanName(wednesday)#" },
                    {field: "thursday",         title: "Th",            width: 58, editor: daybooleanDropDownEditor, template: "#=getDayBooleanName(thursday)#" },
                    {field: "friday",           title: "Fr",            width: 58, editor: daybooleanDropDownEditor, template: "#=getDayBooleanName(friday)#" },
                    {field: "saturday",         title: "Sa",            width: 58, editor: daybooleanDropDownEditor, template: "#=getDayBooleanName(saturday)#" },
                    {field: "level_id",         title: "Level",         width: 90, editor: levelDropDownEditor, template: "#=getLevelName(level_id)#"},
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
                dataSource: readOnlyDataSource,
                height: 390,
                scrollable: true,
                sortable: true,
                reorderable: true,
                selectable: "row",
                resizable: true,
                change: function(e) {
                    // To handle clicking on a row in the main grid and reloading the detail grid with registrations..
                    var selectedRows = this.select();
                    // console.log(selectedRows[0]["rowIndex"]);
                    console.log('here...');
                    console.log(this);
                    var selectedRowIndex = selectedRows[0]["rowIndex"];
                    
                    console.log("selectedgRowIndex = ");
                    console.log(selectedRowIndex);

                    $("#selected_row_index").val(selectedRowIndex);
                    var selectedDataItems = [];
                    for (var i = 0; i < selectedRows.length; i++) {
                        var dataItem = this.dataItem(selectedRows[i]);
                        selectedDataItems.push(dataItem);
                        }
                    // selectedDataItems contains all selected data items
                    var detail_schedule_id = selectedDataItems[0]["id"];
                    // Enable the "New Registration" button and set the href when a row is clicked..
                    $("#new_registration").removeClass('disabled');
                    // $("#new_registration").attr("href", "/scheduleregs/new?schedule_id=" + detail_schedule_id)
                    $("#new_registration").attr("href", "#registrationModal");
                    // Set hidden field to value of this schedule_id..
                    $("#detail_schedule_id").val(detail_schedule_id);
                    
                    console.log("detail_schedule_id = ");
                    console.log(detail_schedule_id);
                    
                    // Refresh the detail grid from the datasource..
                    $("#detailtable").data("kendoGrid").dataSource.read();
                
                    },
                dataBound: function(e) {
                  // alert("Data Bound!");
                  // var grid = $("#datatable").data("kendoGrid");
                  var rowIndex = $("#selected_row_index").val();
                  var rowIndex = rowIndex + 1;
                  console.log("DataBoundrowIndex = ");
                  console.log(rowIndex);

                  $("#new_registration").addClass('disabled');
                  $("#new_registration").attr("href", "#");
                    
                  // grid.select(rowIndex);
                  // grid.select("tr:eq(" + rowIndex + ")");

                },
                columns: [
                    // {field: "checkbox",         title: " ",             width: 27, sortable: false },
                    {field: "program_id",       title: "Session",       width: 105, template: "#=getProgramName(program_id)#" },
                    // {field: "start_date",       title: "Start Date",    format:"{0:yyyy-mm-dd}", width: 90 },
                    // {field: "stop_date",        title: "Stop Date",     format:"{0:yyyy-mm-dd}", width: 90 },
                    {field: "start_date",       title: "Start Date",    format:"{0:MM-dd-yyyy}", width: 90 },
                    {field: "stop_date",        title: "Stop Date",     format:"{0:MM-dd-yyyy}", width: 90 },
                    {field: "lessons",          title: "Lessons",       width: 80 },
                    {field: "start_time",       title: "Start Time",    format:"{0:hh:mm tt}",   width: 90 },
                    {field: "stop_time",        title: "Stop Time",     format:"{0:hh:mm tt}",   width: 90 },
                    {field: "size",             title: "Size",          width: 50 },
                    // {field: "number",           title: "#",             width: 40 },
                    {field: "number_confirmed", title: "#",             width: 40 },
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
            dataSource: detailDataSource,
            height: 120,
            scrollable: true,
            sortable: true,
            reorderable: true,
            resizable: true,
            editable: false,
            columns: [
                {field: "special", title: "Special", width: 70 },
                {field: "child_last_name", title: "Last Name", width: 85},
                {field: "child_first_name", title: "First Name", width: 90 },
                {field: "child_dob", title: "DOB", width: 80, format: "{0:MM-dd-yyyy}"},
                {field: "child_age", title: "Age", width: 60 },
                // {field: "child_age", title: "Age", width: 150 },
                {field: "child_sex", title: "M/F", width: 60 },
                {field: "parent_last_name", title: "Parent Last Name", width: 130 },
                {field: "parent_first_name", title: "Parent First Name", width: 130 },
                {field: "parent_address_1", title: "Address 1", width: 90 },
                {field: "parent_address_2", title: "Address 2", width: 90 },
                {field: "parent_city", title: "City", width: 75 },
                {field: "parent_state", title: "State", width: 60 },
                {field: "parent_zip", title: "ZIP", width: 55 },
                {field: "parent_home_phone", title: "Home Phone", width: 100 },
                {field: "parent_work_phone", title: "Work Phone", width: 100 },
                {field: "parent_cell_phone", title: "Cell Phone", width: 95 },
                {field: "parent_email", title: "Email", width: 120 },
                {field: "status", title: "Status", width: 70 },
                {field: "class_cost", title: "Class Cost", width: 90 },
                {field: "entry_date", title: "Entry Date", width: 90, format: "{0:MM-dd-yyyy}"},
                {field: "exit_date", title: "Exit Date", width: 80, format: "{0:MM-dd-yyyy}"},
                {field: "skill", title: "Skill", width: 80 },
                {field: "continuance", title: "Continuance", width: 100 },
                {field: "comments", title: "Comments", width: 90 },
                {field: "payment_plan_name", title: "Payment Plan", width: 100 },
                {field: "payment_due_date", title: "Payment Due Date", width: 140, format: "{0:MM-dd-yyyy}"},
                {field: "registration_date", title: "Registration Date", format:"{0:MM-dd-yyyy}", width: 130 },
                {field: "referral", title: "Referral", width: 75 },
                {field: "referred_by", title: "Referred By", width: 90 },
                {field: "user", title: "User", width: 80 },
                {field: "registration_id", title: "Reg #", width: 60 },
                {field: "promoted_to", title: "Promoted To", width: 100 },
                {field: "emergency_contact", title: "Emergency Contact", width: 140 },
                {field: "emergency_phone", title: "Emergency Phone", width: 135 }
                ]
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
        .kendoTimePicker({
            change: function() {
              // var timevalue = this.value();
              // console.log(timevalue); //value is the selected date in the timepicker
            }
        });
}


// Day Booleans
function getDayBooleanName(dayboolean_id_param) {
    if (dayboolean_id_param) {
        return "Yes";
    } else {
        return "No";
    }
}

function daybooleanDropDownEditor(container, options) {
    $('<input required data-text-field="dayboolean_name" data-value-field="dayboolean_id" data-bind="value:' + options.field + '"/>')
    .appendTo(container)
    .kendoDropDownList({
        autoBind: false,
        dataSource: daybooleans
    });
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


$(document).ready(function () {

    // Add bootstrap datepicker
    $('#schedule_start_date').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true
    });

    // Add bootstrap datepicker
    $('#schedule_stop_date').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true
    });



});


function submit_create_registration() {
    // var relArr="";
    // $("input:checkbox.select_one:checked").each(function(){
    //     relArr = relArr.concat("schedule_ids[]=",$(this).attr('rel'),"&");
    // });
    // relArr = relArr.replace(/&$/,"");
    window.location.href = ('/scheduleregs/new?schedule_id=' + $("#detail_schedule_id").val());
    // $.post('/registrations/new?schedule_id=' + $("#detail_schedule_id").val();
    // var qsrl = $("#schedule_search").serialize();
    // $("#datatable").data("kendoGrid").dataSource.read(qsrl);
}






