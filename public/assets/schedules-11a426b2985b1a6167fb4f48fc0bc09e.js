function dateEditor(e,t){$('<input data-text-field="'+t.field+'" data-value-field="'+t.field+'" data-bind="value:'+t.field+'"data-format="'+t.format+'"/>').appendTo(e).kendoDatePicker({})}function timeTurner(e,t){$('<input data-text-field="'+t.field+'" data-value-field="'+t.field+'" data-bind="value:'+t.field+'"data-format="'+t.format+'"/>').appendTo(e).kendoTimePicker({})}function getDayBooleanName(e){return e?"Yes":"No"}function daybooleanDropDownEditor(e,t){$('<input required data-text-field="dayboolean_name" data-value-field="dayboolean_id" data-bind="value:'+t.field+'"/>').appendTo(e).kendoDropDownList({autoBind:!1,dataSource:daybooleans})}function getLevelName(e){for(var t=0,n=levels.length;t<n;t++)if(levels[t].level_id===e)return levels[t].level_name}function levelDropDownEditor(e,t){$('<input required data-text-field="level_name" data-value-field="level_id" data-bind="value:'+t.field+'"/>').appendTo(e).kendoDropDownList({autoBind:!1,dataSource:levels})}function getActivityName(e){for(var t=0,n=activities.length;t<n;t++)if(activities[t].activity_id===e)return activities[t].activity_name}function activityDropDownEditor(e,t){$('<input required data-text-field="activity_name" data-value-field="activity_id" data-bind="value:'+t.field+'"/>').appendTo(e).kendoDropDownList({autoBind:!1,dataSource:activities})}function getProgramName(e){for(var t=0,n=programs.length;t<n;t++)if(programs[t].program_id===e)return programs[t].program_name}function programDropDownEditor(e,t){$('<input required data-text-field="program_name" data-value-field="program_id" data-bind="value:'+t.field+'"/>').appendTo(e).kendoDropDownList({autoBind:!1,dataSource:programs})}function getFacilityName(e){for(var t=0,n=facilities.length;t<n;t++)if(facilities[t].facility_id===e)return facilities[t].facility_name}function facilityDropDownEditor(e,t){$('<input required data-text-field="facility_name" data-value-field="facility_id" data-bind="value:'+t.field+'"/>').appendTo(e).kendoDropDownList({autoBind:!1,dataSource:facilities})}function getTypeName(e){for(var t=0,n=types.length;t<n;t++)if(types[t].type_id===e)return types[t].type_name}function typeDropDownEditor(e,t){$('<input required data-text-field="type_name" data-value-field="type_id" data-bind="value:'+t.field+'"/>').appendTo(e).kendoDropDownList({autoBind:!1,dataSource:types})}function getTeacherName(e){for(var t=0,n=teachers.length;t<n;t++)if(teachers[t].teacher_id===e)return teachers[t].teacher_name}function teacherDropDownEditor(e,t){$('<input required data-text-field="teacher_name" data-value-field="teacher_id" data-bind="value:'+t.field+'"/>').appendTo(e).kendoDropDownList({autoBind:!1,dataSource:teachers})}function getZoneName(e){for(var t=0,n=zones.length;t<n;t++)if(zones[t].zone_id===e)return zones[t].zone_name}function zoneDropDownEditor(e,t){$('<input required data-text-field="zone_name" data-value-field="zone_id" data-bind="value:'+t.field+'"/>').appendTo(e).kendoDropDownList({autoBind:!1,dataSource:zones})}function getLocationName(e){for(var t=0,n=locations.length;t<n;t++)if(locations[t].location_id===e)return locations[t].location_name}function locationDropDownEditor(e,t){$('<input required data-text-field="location_name" data-value-field="location_id" data-bind="value:'+t.field+'"/>').appendTo(e).kendoDropDownList({autoBind:!1,dataSource:locations})}function submit_create_registration(){window.location.href="/scheduleregs/new?schedule_id="+$("#detail_schedule_id").val()}$(function(){$(this).on($.modal.CLOSE,function(e,t){alert("Wow it workssss...")})}),$(function(){return $(".chzn-select").chosen().change(function(){var e=$("#schedule_search").serialize();$("#datatable").data("kendoGrid").dataSource.read(e)})}),$(function(){return $("#q_start_date_gteq").kendoDatePicker({format:"yyyy-MM-dd"})}),$(function(){return $("#q_start_date_gteq").bind("change",function(){var e=$("#schedule_search").serialize();$("#datatable").data("kendoGrid").dataSource.read(e)})}),$(function(){return $("#q_start_date_lteq").kendoDatePicker({format:"yyyy-MM-dd"})}),$(function(){return $("#q_start_date_lteq").bind("change",function(){var e=$("#schedule_search").serialize();$("#datatable").data("kendoGrid").dataSource.read(e)})}),$(function(){return $("#q_start_time_gteq").kendoTimePicker({})}),$(function(){return $("#q_start_time_gteq").bind("change",function(){var e=$("#schedule_search").serialize();$("#datatable").data("kendoGrid").dataSource.read(e)})}),$(function(){return $("#q_stop_time_lteq").kendoTimePicker({})}),$(function(){return $("#q_stop_time_lteq").bind("change",function(){var e=$("#schedule_search").serialize();$("#datatable").data("kendoGrid").dataSource.read(e)})}),$(function(){$(".modal").bind("beforeShow",function(){alert("beforeShow!!")}).show()});var detail_schedule_id=0,levels=[],activities=[],programs=[],facilities=[],types=[],locations=[],zones=[],teachers=[],daybooleans=[{dayboolean_id:"",dayboolean_name:""},{dayboolean_id:!1,dayboolean_name:"No"},{dayboolean_id:!0,dayboolean_name:"Yes"}];$.getJSON("/levels.json",function(e){levels=e}),$.getJSON("/activities.json",function(e){activities=e}),$.getJSON("/programs.json",function(e){programs=e}),$.getJSON("/facilities.json",function(e){facilities=e}),$.getJSON("/types.json",function(e){types=e}),$.getJSON("/locations.json",function(e){locations=e}),$.getJSON("/zones.json",function(e){zones=e}),$.getJSON("/teachers.json",function(e){teachers=e}),$(document).ready(function(){var e=$("#schedule_search").serialize(),t="/schedules",n=new kendo.data.DataSource({transport:{read:{url:function(e){return window.location.href.indexOf("classes")!==-1?t+"/ransack_search?"+$("#schedule_search").serialize():t+"/ransack_read_only_search?"+$("#schedule_search").serialize()},dataType:"json"},update:{url:function(e){return t+"/"+e.id},dataType:"json",contentType:"application/json",type:"PUT"},destroy:{url:function(e){return t+"/"+e.id},dataType:"json",type:"DELETE"},create:{url:t,dataType:"json",contentType:"application/json",type:"POST"},parameterMap:function(e,t){if(t==="create"||t==="update")return JSON.stringify({schedule:e})}},autoSync:!0,schema:{parse:function(e){return $.each(e,function(e,t){t.start_time&&typeof t.start_time=="string"&&(t.start_time=kendo.parseDate(t.start_time,"yyyy-MM-ddTHH:mm:ssZ")),t.stop_time&&typeof t.stop_time=="string"&&(t.stop_time=kendo.parseDate(t.stop_time,"yyyy-MM-ddTHH:mm:ssZ"))}),e},model:{id:"id",fields:{select:{type:"string",editable:!1},program_id:{field:"program_id",defaultValue:1},start_date:{editable:!0},stop_date:{editable:!0},lessons:{editable:!1},start_time:{editable:!0},stop_time:{editable:!0},size:{editable:!0},sunday:{editable:!0},monday:{editable:!0},tuesday:{editable:!0},wednesday:{editable:!0},thursday:{editable:!0},friday:{editable:!0},saturday:{editable:!0},number:{editable:!1},level_id:{field:"level_id",defaultValue:1},absences:{editable:!1},specials:{editable:!1},type_id:{field:"type_id",defaultValue:1},teacher_id:{field:"teacher_id",defaultValue:1},zone_id:{field:"zone_id",defaultValue:1},comments:{editable:!0},id:{editable:!1},activity_id:{field:"activity_id",defaultValue:1},location_id:{field:"location_id",defaultValue:1},facility_id:{field:"facility_id",defaultValue:1}}}}}),r=new kendo.data.DataSource({transport:{read:{url:function(e){return"/scheduleregs/registrations_by_schedule.json?schedule_id="+$("#detail_schedule_id").val()},dataType:"json"}},schema:{parse:function(e){return $.each(e,function(e,t){t.registration_date&&typeof t.registration_date=="string"&&(t.registration_date=kendo.parseDate(t.registration_date,"yyyy-MM-ddTHH:mm:ssZ"))}),e},model:{id:"id",fields:{child_last_name:{editable:!1}}}}});window.location.href.indexOf("classes")!==-1?$("#datatable").kendoGrid({dataSource:n,height:390,scrollable:!0,sortable:!0,reorderable:!0,resizable:!0,editable:!0,columns:[{field:"select",title:" ",width:27,sortable:!1,template:"<input type='checkbox' class='select_one' onclick='checkBoxCount ()' rel='#=id#' />"},{field:"program_id",title:"Session",width:105,editor:programDropDownEditor,template:"#=getProgramName(program_id)#"},{field:"start_date",title:"Start Date",format:"{0:yyyy-mm-dd}",width:90,editor:dateEditor},{field:"stop_date",title:"Stop Date",format:"{0:yyyy-mm-dd}",width:90,editor:dateEditor},{field:"start_time",title:"Start Time",format:"{0:hh:mm tt}",width:90,editor:timeTurner},{field:"stop_time",title:"Stop Time",format:"{0:hh:mm tt}",width:90,editor:timeTurner},{field:"size",title:"Size",width:50},{field:"sunday",title:"Su",width:58,editor:daybooleanDropDownEditor,template:"#=getDayBooleanName(sunday)#"},{field:"monday",title:"Mo",width:58,editor:daybooleanDropDownEditor,template:"#=getDayBooleanName(monday)#"},{field:"tuesday",title:"Tu",width:58,editor:daybooleanDropDownEditor,template:"#=getDayBooleanName(tuesday)#"},{field:"wednesday",title:"We",width:58,editor:daybooleanDropDownEditor,template:"#=getDayBooleanName(wednesday)#"},{field:"thursday",title:"Th",width:58,editor:daybooleanDropDownEditor,template:"#=getDayBooleanName(thursday)#"},{field:"friday",title:"Fr",width:58,editor:daybooleanDropDownEditor,template:"#=getDayBooleanName(friday)#"},{field:"saturday",title:"Sa",width:58,editor:daybooleanDropDownEditor,template:"#=getDayBooleanName(saturday)#"},{field:"level_id",title:"Level",width:90,editor:levelDropDownEditor,template:"#=getLevelName(level_id)#"},{field:"type_id",title:"Type",width:100,editor:typeDropDownEditor,template:"#=getTypeName(type_id)#"},{field:"teacher_id",title:"Teacher",width:120,editor:teacherDropDownEditor,template:"#=getTeacherName(teacher_id)#"},{field:"zone_id",title:"Zone",width:60,editor:zoneDropDownEditor,template:"#=getZoneName(zone_id)#"},{field:"comments",title:"Comments",width:150},{field:"id",title:"Class#",width:70},{field:"activity_id",title:"Activity",width:130,editor:activityDropDownEditor,template:"#=getActivityName(activity_id)#"},{field:"location_id",title:"Location",width:100,editor:locationDropDownEditor,template:"#=getLocationName(location_id)#"},{field:"facility_id",title:"Pool",width:100,editor:facilityDropDownEditor,template:"#=getFacilityName(facility_id)#"}]}):$("#datatable").kendoGrid({dataSource:n,height:390,scrollable:!0,sortable:!0,reorderable:!0,selectable:"row",resizable:!0,change:function(e){var t=this.select(),n=[];for(var r=0;r<t.length;r++){var i=this.dataItem(t[r]);n.push(i)}var s=n[0].id;$("#new_registration").removeClass("disabled"),$("#new_registration").attr("href","/scheduleregs/new?schedule_id="+s),$("#detail_schedule_id").val(s)},columns:[{field:"program_id",title:"Session",width:105,template:"#=getProgramName(program_id)#"},{field:"start_date",title:"Start Date",format:"{0:yyyy-mm-dd}",width:90},{field:"stop_date",title:"Stop Date",format:"{0:yyyy-mm-dd}",width:90},{field:"lessons",title:"Lessons",width:80},{field:"start_time",title:"Start Time",format:"{0:hh:mm tt}",width:90},{field:"stop_time",title:"Stop Time",format:"{0:hh:mm tt}",width:90},{field:"size",title:"Size",width:50},{field:"number",title:"#",width:40},{field:"level_id",title:"Level",width:90,template:"#=getLevelName(level_id)#"},{field:"absences",title:"Abs",width:50},{field:"specials",title:"Spec",width:55},{field:"type_id",title:"Type",width:100,template:"#=getTypeName(type_id)#"},{field:"teacher_id",title:"Teacher",width:120,template:"#=getTeacherName(teacher_id)#"},{field:"zone_id",title:"Zone",width:60,template:"#=getZoneName(zone_id)#"},{field:"comments",title:"Comments",width:150},{field:"id",title:"Class#",width:70},{field:"activity_id",title:"Activity",width:130,template:"#=getActivityName(activity_id)#"},{field:"location_id",title:"Location",width:100,template:"#=getLocationName(location_id)#"},{field:"facility_id",title:"Pool",width:100,template:"#=getFacilityName(facility_id)#"}]}),$("#detailtable").kendoGrid({dataSource:r,height:120,scrollable:!0,sortable:!0,reorderable:!0,resizable:!0,editable:!1,columns:[{field:"special",title:"Special",width:70},{field:"child_last_name",title:"Last Name",width:85},{field:"child_first_name",title:"First Name",width:90},{field:"child_dob",title:"DOB",width:80},{field:"child_age",title:"Age",width:50},{field:"child_sex",title:"M/F",width:50},{field:"parent_last_name",title:"Parent Last Name",width:130},{field:"parent_first_name",title:"Parent First Name",width:130},{field:"parent_address_1",title:"Address 1",width:90},{field:"parent_address_2",title:"Address 2",width:90},{field:"parent_city",title:"City",width:75},{field:"parent_state",title:"State",width:60},{field:"parent_zip",title:"ZIP",width:55},{field:"parent_home_phone",title:"Home Phone",width:100},{field:"parent_work_phone",title:"Work Phone",width:100},{field:"parent_cell_phone",title:"Cell Phone",width:95},{field:"parent_email",title:"Email",width:120},{field:"status",title:"Status",width:70},{field:"class_cost",title:"Class Cost",width:90},{field:"entry_date",title:"Entry Date",width:90},{field:"exit_date",title:"Exit Date",width:80},{field:"skill",title:"Skill",width:80},{field:"continuance",title:"Continuance",width:100},{field:"comments",title:"Comments",width:90},{field:"payment_due_date",title:"Payment Due Date",width:140},{field:"registration_date",title:"Registration Date",format:"{0:yyyy-MM-dd}",width:130},{field:"referral",title:"Referral",width:75},{field:"referred_by",title:"Referred By",width:90},{field:"user",title:"User",width:80},{field:"registration_id",title:"Reg #",width:60},{field:"promoted_to",title:"Promoted To",width:100},{field:"emergency_contact",title:"Emergency Contact",width:140},{field:"emergency_phone",title:"Emergency Phone",width:135}]})}),$(document).ready(function(){$("#schedule_start_date").datepicker({format:"yyyy-mm-dd",autoclose:!0}),$("#schedule_stop_date").datepicker({format:"yyyy-mm-dd",autoclose:!0})});