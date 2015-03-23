<?php /**
 * Display appointments
 */

/**
 * Configuration file
 */
include_once(dirname(__FILE__).'/../config.inc.php');

/**
 * Database file
 */
include ("../db.inc.php");

/**
 * XHTML functions
 */
include ("../functions/functions.xhtml.php");

/**
 * Operator functions
 */
include ("../functions/functions.operator.php");

/**
 * Input functions
 */
include ("../functions/functions.input.php");

/**
 * Calendar functions
 */
include ("../functions/functions.calendar.php");

$css = array(
"../include/bootstrap-3.3.2/css/bootstrap.min.css", 
"../include/bootstrap-3.3.2/css/bootstrap-theme.min.css",
"../include/font-awesome-4.3.0/css/font-awesome.css",
"../include/jquery-ui/css/smoothness/jquery-ui-1.8.2.custom.css",
"../include/timepicker/jquery-ui.min.css",
"../include/timepicker/jquery-ui-timepicker-addon.css",
"../css/custom.css"
			);
$js_head = array(
"../js/jquery-2.1.3.min.js",
"../include/bootstrap-3.3.2/js/bootstrap.min.js",
"../include/timepicker/jquery-ui.min.js",
//"../include/jquery-ui/js/jquery-ui-1.8.2.custom.min.js",
"../include/timepicker/jquery-ui-timepicker-addon.js",
"../include/timepicker/jquery-ui-timepicker-ru.js",
				);
$js_foot = array(
"../js/bootstrap-confirmation.js",
"../js/custom.js"
				);
 
//create new or update appointment
if (isset($_GET['start']) && isset($_GET['end']) && isset($_GET['update']))
{	
	$start = $db->qstr($_GET['start']);
	$end = $db->qstr($_GET['end']);
	$contact_phone_id = bigintval($_GET['contact_phone_id']);
	$respondent_id = bigintval($_GET['respondent_id']);
	$require_operator_id = "NULL";
	if ($_GET['require_operator_id'] > 1) $require_operator_id = bigintval($_GET['require_operator_id']);
	
	if ($_GET['new'] == 'create'){
		$case_id = bigintval($_GET['case_id']);
		$operator_id = get_operator_id();
		if ($operator_id == false) die();
		$sql = "SELECT Time_zone_name FROM respondent WHERE respondent_id = '$respondent_id'";
		$respondent_tz = $db->GetOne($sql);

		// create a call attempt
		$sql = "INSERT INTO call_attempt (call_attempt_id,case_id,operator_id,respondent_id,start,end)
		VALUES (NULL,$case_id,$operator_id,$respondent_id,CONVERT_TZ(NOW(),@@session.time_zone,'UTC'),CONVERT_TZ(NOW(),@@session.time_zone,'UTC'))";
		$db->Execute($sql);
		
		$call_attempt_id = $db->Insert_ID();
		
		$sql = "INSERT INTO `appointment` (appointment_id,case_id,contact_phone_id,call_attempt_id,start,end,require_operator_id,respondent_id,completed_call_id)
				VALUES(NULL,$case_id,$contact_phone_id,$call_attempt_id,CONVERT_TZ($start,'$respondent_tz','UTC'),CONVERT_TZ($end,'$respondent_tz','UTC'),$require_operator_id,$respondent_id,NULL)";
        $db->Execute($sql);
		
		$appointment_id = $db->Insert_ID();

		$_GET['appointment_id'] = $appointment_id;
		$appointment_id = bigintval($_GET['appointment_id']);		
		
	} else {

		$appointment_id = bigintval($_GET['appointment_id']);
		
		//Edit this appointment in the database
		$sql = "UPDATE appointment as a, respondent as r
		SET a.start = CONVERT_TZ($start,r.Time_zone_name,'UTC'), a.end = CONVERT_TZ($end,r.Time_zone_name,'UTC'), a.contact_phone_id = $contact_phone_id, a.respondent_id = $respondent_id, a.require_operator_id = $require_operator_id
		WHERE a.appointment_id = $appointment_id
		AND r.respondent_id = $respondent_id";

		$db->Execute($sql);
	}	
	unset ($_GET['start'],$_GET['end'],$_GET['appointment_id'],$_GET['case_id'],$_GET['new'],$_GET['update']); 
}
	

if ( (isset($_GET['appointment_id']) && isset($_GET['case_id'])) ||(($_GET['new'] == 'new') && isset($_GET['case_id'])))
{
	$appointment_id = bigintval($_GET['appointment_id']);
	$case_id = bigintval($_GET['case_id']);

	if (isset($_GET['delete']))
	{
		$sql = "DELETE FROM appointment
			WHERE appointment_id = '$appointment_id'";
		$db->Execute($sql);
	
		xhtml_head(T_("Now modify case outcome"),true,$css,$js_head);
	
		print "<div class='col-sm-6'><p class='well'>" . T_("The appointment has been deleted. Now you must modify the case outcome") . "</p>
				<a href='supervisor.php?case_id=$case_id' class='btn btn-default'>" . T_("Modify case outcome") . "</a></div>";
	}
	else
	{
		//Display an edit form
		
		if ($_GET['new'] == 'new'){$title = T_("Create NEW appointment");} else{$title = T_("Edit appointment"); $subtitle = "ID&ensp;" . $appointment_id;} 
		
		xhtml_head($title,true,$css,$js_head,false,false,false,$subtitle);
		$lang = DEFAULT_LOCALE;
		print "<script type='text/javascript'> 
		$(document).ready(function() { var startDateTextBox = $('#start'); var endDateTextBox = $('#end');
			$.timepicker.datetimeRange( 
				startDateTextBox,endDateTextBox,{
				minInterval: (1000*60*15), // 15min
				dateFormat: 'yy-mm-dd', 
				timeFormat: 'HH:mm:ss',
				showSecond: false,
				regional: '$lang',
				hourMin: 9,
				hourMax: 21,
				stepMinute: 5,
				hourGrid: 2,
				minuteGrid: 10,
				start: {minDateTime: new Date()}, // start picker options
				end: { } // end picker options
				});});</script>";

		if ($_GET['new'] =='new'){
			$start = date("Y-m-d H:m:s");
			$end = date("Y-m-d H:m:s", mktime(0,0,0,date("m"),date("d")+7,date("Y")));
			$rtz = $_GET['rtz'];
		} 
		if  (isset($_GET['appointment_id'])) {
				
			$sql = "SELECT a.contact_phone_id,a.call_attempt_id, CONVERT_TZ(a.start,'UTC',r.Time_zone_name) as `start`, CONVERT_TZ(a.end,'UTC',r.Time_zone_name) as `end`, a.respondent_id, a.require_operator_id, r.Time_zone_name as rtz
			FROM `appointment` as a, respondent as r
			WHERE a.appointment_id = '$appointment_id'
			AND a.case_id = '$case_id'
			AND r.respondent_id = a.respondent_id";

			$rs = $db->GetRow($sql);

			if (!empty($rs)){ 
				$respondent_id = $rs['respondent_id'];
				$contact_phone_id = $rs['contact_phone_id'];
				$require_operator_id = $rs['require_operator_id'];
				$start = $rs['start'];
				$end = $rs['end'];
				$rtz = $rs['rtz'];
			}	
		}
			print "<form action='?' method='get' class='form-horizontal'>";
			print "<label class='pull-left text-right control-label col-sm-2' for='respondent_id'>" . T_("Respondent") . "</label>";
			
			display_chooser($db->GetAll("SELECT respondent_id as value,	CONCAT(firstName,' ',lastName) as description, 
							CASE when respondent_id = '$respondent_id' THEN 'selected=\'selected\'' ELSE '' END as selected
							FROM respondent
							WHERE case_id = '$case_id'"),"respondent_id","respondent_id",false,false,false,true,false,true,"pull-left");

			print "<br/><br/><label for='contact_phone_id' class='pull-left text-right control-label col-sm-2'>" . T_("Contact phone") . "</label>";
			display_chooser($db->GetAll("SELECT contact_phone_id as value, phone as description,
							CASE when contact_phone_id = '$contact_phone_id' THEN 'selected=\'selected\'' ELSE '' END as selected
							FROM contact_phone
							WHERE case_id = '$case_id'"),
							"contact_phone_id","contact_phone_id",false,false,false,true,false,true,"pull-left");
							
		 	print "<div class='clearfix'></div></br><div class='alert alert-info col-sm-6 '>". T_("ATTENTION!    Keep in mind that you're setting 'Start' & 'End' appoinment times in RESPONDENT LOCAL TIME !!!") . "</div><div class='clearfix'></div>";
			date_default_timezone_set($rtz);
			print "<label class='text-right col-sm-2 control-label'>" . T_("Respondent TimeZone") . ":</label>
					<h4 class='col-sm-2  text-danger text-uppercase  fa-lg'>" . $rtz . "</h4>
					<label class=''>" . T_("Respondent Time") . ":&emsp;<b class='fa fa-2x '>" . date("H:i:s") . "</b></label>";
			
			print "<br/><br/><label class='pull-left text-right control-label col-sm-2' for='start'>" . T_("Start time") . "</label>
					<div class='pull-left'><input class='form-control' type='text' value='$start' id='start' name='start'/></div>";
			print "<br/><br/><label class='pull-left text-right control-label col-sm-2' for='end'>" . T_("End time") . "</label>
					<div class='pull-left'><input class='form-control' type='text' value='$end' id='end' name='end'/></div>";
			print "<br/><br/><label class='pull-left text-right control-label col-sm-2' for='require_operator_id'>" . T_("Appointment with") . "</label>";
			$ops = $db->GetAll("SELECT o.operator_id as value,
						CONCAT(o.firstName, ' ', o.lastName) as description,
						CASE WHEN o.operator_id = '$require_operator_id' THEN 'selected=\'selected\'' ELSE '' END as selected
						FROM operator as o");
			$selected = "selected=\'selected\'";
			foreach($ops as $o)
			{
				if (!empty($o['selected']))
				{
					$selected = "";
					break;
				}
			}
			array_unshift($ops,array('value'=>0,'description'=>T_("Any operator"),'selected'=>$selected));
			display_chooser($ops,"require_operator_id","require_operator_id",false,false,false,true,false,true,"pull-left");
			print "<input type='hidden' value='$appointment_id' id='appointment_id' name='appointment_id'/><input type='hidden' value='update' id='update' name='update'/>";
			
			if ($_GET['new'] == 'new') { print "<input type='hidden' value='create' id='new' name='new'/><input type='hidden' value='$case_id' id='case_id' name='case_id'/>";}

			print "<div class='clearfix form-group'></div><br/><br/>
				<div class='col-sm-2'><a href='' onclick='history.back();return false;' class='btn btn-default pull-left'><i class='fa fa-ban fa-lg'></i>&emsp;" . T_("Cancel edit") . "</a></div>";
			
			print "<div class='col-sm-2'><button type='submit' class='btn btn-primary btn-block'><i class='fa fa-floppy-o fa-lg'></i>&emsp;" . T_("Save changes") . "</button></div>";

			print "<div class='col-sm-2'><a href='' class='btn btn-default pull-right'  toggle='confirmation' data-placement='left' data-href='?delete=delete&amp;appointment_id=$appointment_id&amp;case_id=$case_id' ><i class='fa fa-trash fa-lg text-danger'></i>&emsp;" . T_("Delete this appointment") . "</a></div>";

			print "</form>";
	}
}
else {
	$operator_id = get_operator_id();
	$subtitle = T_("Appointments"); 
	xhtml_head(T_("Display Appointments"),true,$css,$js_head, false,30); //array("../css/table.css")
	
	print "<h3>" . T_("All appointments (with times displayed in your time zone)") . "</h3>";

	$sql = "SELECT q.description, CONVERT_TZ(a.start,'UTC',@@session.time_zone) as start, CONVERT_TZ(a.end,'UTC',@@session.time_zone) as end, CONCAT(r.firstName, ' ', r.lastName) as resp, IFNULL(ou.description,'" . TQ_("Not yet called") . "') as outcome, oo.firstName as makerName, ooo.firstName as callerName, 
	CONCAT('<a href=\'supervisor.php?case_id=', c.case_id, '\'>', c.case_id, '</a>') as case_id, 
	CONCAT('&emsp;<a href=\'\'><i class=\'fa fa-trash-o fa-lg text-danger\' toggle=\'confirmation\' data-placement=\'left\' data-href=\'?case_id=', c.case_id, '&amp;appointment_id=', a.appointment_id, '&amp;delete=delete\'  ></i></a>&emsp;') as link, 
	CONCAT('&emsp;<a href=\'?case_id=', c.case_id, '&amp;appointment_id=', a.appointment_id, '\'><i class=\'fa fa-pencil-square-o fa-lg\' ></i></a>&emsp;') as edit,IFNULL(ao.firstName,'" . TQ_("Any operator") . "') as witho 
	FROM appointment as a 
	JOIN (`case` as c, respondent as r, questionnaire as q, operator as oo, call_attempt as cc) on (a.case_id = c.case_id and a.respondent_id = r.respondent_id and q.questionnaire_id = c.questionnaire_id and a.call_attempt_id = cc.call_attempt_id and cc.operator_id =  oo.operator_id) 
	LEFT JOIN (`call` as ca, outcome as ou, operator as ooo) ON (ca.call_id = a.completed_call_id and ou.outcome_id = ca.outcome_id and ca.operator_id = ooo.operator_id) 
	LEFT JOIN operator AS ao ON ao.operator_id = a.require_operator_id 
	WHERE a.end >= CONVERT_TZ(NOW(),'System','UTC') 
	ORDER BY a.start ASC";
	
	$rs = $db->GetAll($sql);
	if (!empty($rs)) {
		translate_array($rs,array("outcome"));
		xhtml_table($rs,array("description","case_id","start","end","edit","makerName","witho","resp","outcome","callerName","link"),array(T_("Questionnaire"),T_("Case ID"),T_("Start"),T_("End"),"&emsp;<i class='fa fa-pencil-square-o fa-lg' data-toggle='tooltip' title='" . T_("Edit") . "'></i>&emsp;",T_("Created by"),T_("Appointment with"),T_("Respondent"),T_("Current outcome"),T_("Operator who called"),"&emsp;<i class='fa fa-trash-o fa-lg' data-toggle='tooltip' title='" . T_("Delete") . "'></i>&emsp;"),"tclass",false,false,"bs-table");
		
	} else print "<p>" . T_("No appointments in the future") . "</p>";
	
}
xhtml_foot($js_foot);
?>
<script type="text/javascript">
$('[toggle="confirmation"]').confirmation()
</script>