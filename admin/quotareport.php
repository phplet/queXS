<?php
/**
 * Display a report of all quota's
 * a. (Standard quota) Monitor outcomes of questions in completed questionnaires, and exclude selected sample records when completion limit is reached
 * b. (Replicate quota) Exclude selected sample records 
 * c. (Questionnaire quota) Monitor outcomes of questions in completed questionnaires, and abort interview when completion limit is reached 
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
 * @copyright Australian Consortium for Social and Political Research Incorporated (ACSPRI) 2009
 * @package queXS
 * @subpackage admin
 * @link http://www.acspri.org.au/ queXS was writen for ACSPRI
 * @license http://opensource.org/licenses/gpl-2.0.php The GNU General Public License (GPL) Version 2
 * 
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
 * Display functions
 */
include("../functions/functions.display.php");

/**
 * Input functions
 */
include("../functions/functions.input.php");

/**
 * Operator functions
 */
include("../functions/functions.operator.php");

/**
 * Limesurvey functions
 */
include("../functions/functions.limesurvey.php");

xhtml_head(T_("Quota report"),true,array("../css/table.css"),array("../js/window.js"));

print "<h2>" . T_("Select a questionnaire from the list below") . "</h2>";
$questionnaire_id = false;
if (isset($_GET['questionnaire_id'])) $questionnaire_id = bigintval($_GET['questionnaire_id']);
display_questionnaire_chooser($questionnaire_id);

if ($questionnaire_id)
{
	print "<h2>" . T_("Select a sample from the list below") . "</h2>";
	$sample_import_id = false;
	if (isset($_GET['sample_import_id'])) $sample_import_id = bigintval($_GET['sample_import_id']);
	display_sample_chooser($questionnaire_id,$sample_import_id);

	if ($sample_import_id)
	{
		if (isset($_GET['rowquota']))
		{
			$qsq = bigintval($_GET['rowquota']);
			$qr = 0;
			if (isset($_GET['close'])) $qr = 1;
			$sql = "UPDATE questionnaire_sample_quota_row
				SET quota_reached = $qr
				WHERE questionnaire_sample_quota_row_id = '$qsq'";
			$db->Execute($sql);
			if ($qr == 1)
				close_row_quota($qsq);
			else
				open_row_quota($qsq,false);
		}

		//Display report of quotas 
		$report = array();
	
		//Rows to display: Strata Status Quota Sample Sample Used Sample Remaining Completes % Complete

		// Firstly, for the entire sample

		//We need to calc Sample size, Sample drawn, Sample remain, Completions, %complete
		$sql = "SELECT (c.sample_id is not null) as type, count(*) as count
			FROM sample as s
			JOIN questionnaire_sample as qs ON (qs.questionnaire_id = '$questionnaire_id' and qs.sample_import_id = s.import_id)
			LEFT JOIN `case` as c ON (c.questionnaire_id = qs.questionnaire_id and c.sample_id = s.sample_id)
			WHERE s.import_id = '$sample_import_id'
			GROUP BY (c.sample_id is not null)";
 
		$rs = $db->GetAll($sql);

		//type == 1 is drawn from sample, type == 0 is remains in sample
		$drawn = 0;
		$remain = 0;
		
		foreach ($rs as $r)
		{
			if ($r['type'] == 1) $drawn = $r['count'];
			if ($r['type'] == 0) $remain = $r['count'];
		}

		$sql = "SELECT count(*) as count
			FROM `case` as c, sample as s
			WHERE c.current_outcome_id = 10
			AND s.import_id = '$sample_import_id'
			AND s.sample_id = c.sample_id
			AND c.questionnaire_id = '$questionnaire_id'";

		$rs = $db->GetRow($sql);
		
		$completions = $rs['count'];

		$report[] = array("strata" => T_("Total sample"), "quota" => $drawn + $remain, "sample" => $drawn + $remain, "sampleused" => $drawn, "sampleremain" => $remain, "completions" => $completions, "perc" => ROUND(($completions / ($drawn + $remain)) * 100,2));

		//a. (Standard quota) Monitor outcomes of questions in completed questionnaires, and exclude selected sample records when completion limit is reached
		//b. (Replicate quota) Exclude selected sample records (where lime_sgqa == -1) 
		$sql = "SELECT questionnaire_sample_quota_row_id,lime_sgqa,value,completions,quota_reached,lime_sid,comparison,exclude_var,exclude_val,qsq.description
			FROM questionnaire_sample_quota_row as qsq, questionnaire as q
			WHERE qsq.questionnaire_id = '$questionnaire_id'
			AND qsq.sample_import_id = '$sample_import_id'
			AND q.questionnaire_id = '$questionnaire_id'";
	
		$r = $db->GetAll($sql);

		foreach ($r as $v)
		{
			if ($v['lime_sgqa'] == -1)
			{
				$completions = limesurvey_quota_replicate_completions($v['lime_sid'],$questionnaire_id,$sample_import_id,$v['exclude_val'],$v['exclude_var']);
				$v['completions'] = "";
				$perc = "";
			}
			else
			{
				$completions = limesurvey_quota_completions($v['lime_sgqa'],$v['lime_sid'],$questionnaire_id,$sample_import_id,$v['value'],$v['comparison']);
				$perc = ($v['completions'] <= 0 ? 0 : ROUND(($completions / ($v['completions'])) * 100,2));
			}

			//We need to calc Sample size, Sample drawn, Sample remain
			$sql = "SELECT (c.sample_id is not null) as type, count(*) as count
				FROM sample as s
				JOIN questionnaire_sample as qs ON (qs.questionnaire_id = '$questionnaire_id' and qs.sample_import_id = s.import_id)
				JOIN sample_var as sv ON (sv.sample_id = s.sample_id AND sv.var LIKE '{$v['exclude_var']}' AND sv.val LIKE '{$v['exclude_val']}')
				LEFT JOIN `case` as c ON (c.questionnaire_id = qs.questionnaire_id and c.sample_id = s.sample_id)
				WHERE s.import_id = '$sample_import_id'
				GROUP BY (c.sample_id is not null)";

 			$rs = $db->GetAll($sql);
			//type == 1 is drawn from sample, type == 0 is remains in sample
			$drawn = 0;
			$remain = 0;
		
			foreach ($rs as $r)
			{
				if ($r['type'] == 1) $drawn = $r['count'];
				if ($r['type'] == 0) $remain = $r['count'];
			}

			if ($completions < $v['completions'] || $v['lime_sgqa'] == -1) //if completions less than the quota, allow for closing/opening
			{
				if ($v['quota_reached'] == 1)
					$status = "<a href='?questionnaire_id=$questionnaire_id&amp;sample_import_id=$sample_import_id&amp;rowquota={$v['questionnaire_sample_quota_row_id']}&amp;open=open'>" . T_("closed") . "</a>";
				else
					$status = "<a href='?questionnaire_id=$questionnaire_id&amp;sample_import_id=$sample_import_id&amp;rowquota={$v['questionnaire_sample_quota_row_id']}&amp;close=close'>" . T_("open") . "</a>";
			}
			else
			{
				if ($v['quota_reached'] == 1)
					$status = T_("closed");
				else
					$status = T_("open");
			}
			
			$report[] = array("strata" => "<a href='quotarow.php?questionnaire_id=$questionnaire_id&amp;sample_import_id=$sample_import_id'>" . $v['description'] . "</a>", "status" => $status, "quota" => $v['completions'], "sample" => $drawn + $remain, "sampleused" => $drawn, "sampleremain" => $remain, "completions" => $completions, "perc" => $perc);
		}

		//c. (Questionnaire quota) Monitor outcomes of questions in completed questionnaires, and abort interview when completion limit is reached 
		$sql = "SELECT *
			FROM " . LIME_PREFIX . "quota as qu, questionnaire as q
			WHERE qu.sid = q.lime_sid
			AND qu.active = 1
			AND q.questionnaire_id = '$questionnaire_id'";
				
		$rs = $db->GetAll($sql);

		//for each limesurvey quota
		foreach($rs as $r)
		{
			//limesurvey quotas for this question
			$quotas = (get_limesurvey_quota_info($r['id']));
			$sqlq = array();

			foreach ($quotas as $q)
				$sqlq[] = "s." . $q['fieldname'] . " = '" . $q['value'] . "'";
			
			$sql = "SELECT COUNT(id) as count
				FROM ".LIME_PREFIX."survey_{$r['sid']} as s
				JOIN `case` as c ON (c.questionnaire_id = '$questionnaire_id')
				JOIN `sample` as sam ON (c.sample_id = sam.sample_id AND sam.import_id = '$sample_import_id')
				WHERE ".implode(' AND ',$sqlq)." "." 
				AND submitdate IS NOT NULL
				AND s.token = c.case_id";

			$rs = $db->GetRow($sql);

			$completions = $rs['count'];
			$perc = ROUND(($completions / $r['qlimit']) * 100,2);
			
			$report[] = array("strata" => "<a href='" . LIME_URL . "/admin/admin.php?action=quotas&sid={$r['sid']}&quota_id={$r['id']}&subaction=quota_editquota'>" . $r['name'] . "</a>", "quota" => $r['qlimit'], "completions" => $completions, "perc" => $perc);
		}

		xhtml_table($report,array("strata","status","quota","sample","sampleused","sampleremain","completions","perc"),array(T_("Strata"),T_("Status"),T_("Quota"),T_("Sample"),T_("Sample Used"),T_("Sample Remaining"),T_("Completions"),T_("% Complete")),"tclass",false,false);
	}
}

xhtml_foot();


?>
