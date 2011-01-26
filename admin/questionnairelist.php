<?
/**
 * Manage questionnaires by editing them or disabling/enabling them
 *
 *
 *	This file is part of queXS
 *	
 *	queXS is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation; either version 2 of the License, or
 *	(at your option) any later version.
 *	
 *	queXS is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *	
 *	You should have received a copy of the GNU General Public License
 *	along with queXS; if not, write to the Free Software
 *	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 *
 * @author Adam Zammit <adam.zammit@acspri.org.au>
 * @copyright Australian Consortium for Social and Political Research Incorporated (ACSPRI) 2011
 * @package queXS
 * @subpackage admin
 * @link http://www.acspri.org.au/ queXS was writen for ACSPRI
 * @license http://opensource.org/licenses/gpl-2.0.php The GNU General Public License (GPL) Version 2
 *
 */

/**
 * Configuration file
 */
include ("../config.inc.php");

/**
 * Database file
 */
include ("../db.inc.php");

/**
 * XHTML functions
 */
include ("../functions/functions.xhtml.php");

/**
 * Input functions
 */
include("../functions/functions.input.php");

/**
 * CKEditor
 */
include("../include/ckeditor/ckeditor.php");

global $db;


if (isset($_GET['disable']))
{
	$questionnaire_id = intval($_GET['disable']);

	$sql = "UPDATE questionnaire
		SET enabled = 0
		WHERE questionnaire_id = '$questionnaire_id'";

	$db->Execute($sql);	
}

if (isset($_GET['enable']))
{
	$questionnaire_id = intval($_GET['enable']);

	$sql = "UPDATE questionnaire
		SET enabled = 1
		WHERE questionnaire_id = '$questionnaire_id'";

	$db->Execute($sql);	
}

if (isset($_POST['update']) && isset($_GET['modify']))
{
	$questionnaire_id = intval($_GET['modify']);

	$ras =0;
	$rws = 0;
	$rs = 0;
	if (isset($_POST['ras'])) $ras = 1;
	if (isset($_POST['rws'])) $rws = 1;
	
	$name = $db->qstr(html_entity_decode($_POST['description']));
	if (isset($_POST['rs_intro']))
	{
		$rs = 1;
		$rs_intro = $db->qstr(html_entity_decode($_POST['rs_intro']));
		$rs_project_intro = $db->qstr(html_entity_decode($_POST['rs_project_intro']));
		$rs_callback = $db->qstr(html_entity_decode($_POST['rs_callback']));
		$rs_answeringmachine = $db->qstr(html_entity_decode($_POST['rs_answeringmachine']));
	}
	$info  = $db->qstr(html_entity_decode($_POST['info']));
	$rs_project_end = $db->qstr(html_entity_decode($_POST['rs_project_end'],true));

	$sql = "UPDATE questionnaire
		SET description = $name, info = $info, rs_project_end = $rs_project_end, restrict_appointments_shifts = '$ras', restrict_work_shifts = '$rws'
		WHERE questionnaire_id = '$questionnaire_id'";

	$db->Execute($sql);

	if ($rs)
	{
		$sql = "UPDATE questionnaire
			SET rs_intro = $rs_intro, rs_project_intro = $rs_project_intro, rs_callback =  $rs_callback, rs_answeringmachine = $rs_answeringmachine
			WHERE questionnaire_id = '$questionnaire_id'";

		$db->Execute($sql);
	}

	
}

xhtml_head(T_("Questionnaire list"),true,array("../css/table.css"));
	

if (isset($_GET['modify']))
{
	$questionnaire_id = intval($_GET['modify']);

	$CKEditor = new CKEditor();
	
	$ckeditorConfig = array("toolbar" => array(array("tokens","-","Source"),
		array("Cut","Copy","Paste","PasteText","PasteFromWord","-","Print","SpellChecker"),
		array("Undo","Redo","-","Find","Replace","-","SelectAll","RemoveFormat"),
		"/",
		array("Bold","Italic","Underline","Strike","-","Subscript","Superscript"),
		array("NumberedList","BulletedList","-","Outdent","Indent","Blockquote"),
		array('JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'),
		array('BidiLtr', 'BidiRtl'),
		array('Link','Unlink','Anchor'),
		array('Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'),
		"/",
		array('Styles','Format','Font','FontSize'),
		array('TextColor','BGColor'),
		array('About')),
		"extraPlugins" => "tokens");
	
	$sql = "SELECT *
		FROM questionnaire
		WHERE questionnaire_id = $questionnaire_id";

	$rs = $db->GetRow($sql);

	$testing = $rws = $ras = "checked=\"checked\"";
	
	if ($rs['restrict_appointments_shifts'] != 1) $ras = "";
	if ($rs['restrict_work_shifts'] != 1) $rws = "";
	if ($rs['testing'] != 1) $testing = "";
	
	echo "<h1>" . $rs['description'] . "</h1>";
	echo "<p><a href='?'>" . T_("Go back") . "</a></p>";
	echo "<p><a href='" . LIME_URL . "admin/admin.php?sid={$rs['lime_sid']}'>" . T_("Edit questionnaire in Limesurvey") . "</a></p>";
	?>
		<form action="?modify=<? echo $questionnaire_id; ?>" method="post">
		<p><? echo T_("Name for questionnaire:"); ?> <input type="text" name="description" value="<? echo $rs['description']; ?>"/></p>
		<p><? echo T_("Restrict appointments to shifts?"); ?> <input name="ras" type="checkbox" <? echo $ras; ?>/></p>
		<p><? echo T_("Restrict work to shifts?"); ?> <input name="rws" type="checkbox" <? echo $rws; ?>/></p>
		<p><? echo T_("Questionnaire for testing only?"); ?> <input name="testing" type="checkbox" disabled="true" <? echo $testing; ?>/></p>
		<? if ($rs['respondent_selection'] == 1 && empty($rs['lime_rs_sid'])) { ?>
		<p><? echo T_("Respondent selection introduction:"); echo $CKEditor->editor("rs_intro",$rs['rs_intro'],$ckeditorConfig);?></p>
		<p><? echo T_("Respondent selection project introduction:"); echo $CKEditor->editor("rs_project_intro",$rs['rs_project_intro'],$ckeditorConfig);?></p>
		<p><? echo T_("Respondent selection callback (already started questionnaire):"); echo $CKEditor->editor("rs_callback",$rs['rs_callback'],$ckeditorConfig);?> </p>
		<p><? echo T_("Message to leave on an answering machine:"); echo $CKEditor->editor("rs_answeringmachine",$rs['rs_answeringmachine'],$ckeditorConfig);?> </p>
		<? } else if (!empty($rs['lime_rs_sid'])) { echo "<p><a href='" . LIME_URL . "admin/admin.php?sid={$rs['lime_rs_sid']}'>" . T_("Edit respondent selection instrument in Limesurvey") . "</a></p>"; } ?>
		<p><? echo T_("Project end text (thank you screen):");echo $CKEditor->editor("rs_project_end",$rs['rs_project_end'],$ckeditorConfig); ?></p>
		<p><? echo T_("Project information for interviewers/operators:");echo $CKEditor->editor("info",$rs['info'],$ckeditorConfig); ?></p>
		<p><input type="submit" name="update" value="<? echo T_("Update Questionnaire"); ?>"/></p>
		</form>
	<?
	
}
else
{
	$columns = array("description","enabledisable","modify");
	$titles = array(T_("Questionnaire"),T_("Enable/Disable"),("Modify"));
	
	$sql = "SELECT
			description,
			CASE WHEN enabled = 0 THEN
				CONCAT('<a href=\'?enable=',questionnaire_id,'\'>" . T_("Enable") . "</a>') 
			ELSE
				CONCAT('<a href=\'?disable=',questionnaire_id,'\'>" . T_("Disable") . "</a>') 
			END
			as enabledisable,
			CONCAT('<a href=\'?modify=',questionnaire_id,'\'>" . T_("Modify"). "</a>') as modify
		FROM questionnaire";
		
	$rs = $db->GetAll($sql);
		
	
	xhtml_table($rs,$columns,$titles);
}

	
xhtml_foot();


?>