<?

/**
 * Functions relating to integration with {@link http://www.limesurvey.org/ LimeSurvey}
 *
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
 * @author Adam Zammit <adam.zammit@deakin.edu.au>
 * @copyright Deakin University 2007,2008
 * @package queXS
 * @subpackage functions
 * @link http://www.deakin.edu.au/dcarf/ queXS was writen for DCARF - Deakin Computer Assisted Research Facility
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
include_once(dirname(__FILE__).'/../db.inc.php');

/**
 * Return the number of completions for a given
 * questionnaire, where the given sample var has
 * the given sample value
 *
 * @param int $lime_sid The limesurvey survey id 
 * @param int $questionnaire_id The questionnaire ID
 * @param int $sample_import_id The sample import ID
 * @param string $val The value to compare
 * @param string $var The variable to compare
 * @return bool|int False if failed, otherwise the number of completions
 * 
 */
function limesurvey_quota_replicate_completions($lime_sid,$questionnaire_id,$sample_import_id,$val,$var)
{
	global $db;

	$sql = "SELECT count(*) as c
		FROM " . LIME_PREFIX . "survey_$lime_sid as s
		JOIN `case` as c ON (c.questionnaire_id = '$questionnaire_id')
		JOIN `sample` as sam ON (c.sample_id = sam.sample_id AND sam.import_id = '$sample_import_id')
		JOIN `sample_var` as sv ON (sv.sample_id = sam.sample_id AND sv.var LIKE '$var' AND sv.val LIKE '$val')
		WHERE s.submitdate IS NOT NULL
		AND s.token = c.token";

	$rs = $db->GetRow($sql);

	if (isset($rs) && !empty($rs))
		return $rs['c'];
	
	return false;
}

/**
 * Return whether the given case matches the requested quota
 *
 * @param string $lime_sgqa The limesurvey SGQA
 * @param int $lime_sid The limesurvey survey id 
 * @param int $case_id The case id
 * @param int $sample_import_id The sample import ID
 * @param string $value The value to compare
 * @param string $comparison The type of comparison
 * @return bool|int False if failed, otherwise 1 if matched, 0 if doesn't
 * 
 */
function limesurvey_quota_match($lime_sgqa,$lime_sid,$case_id,$value,$comparison)
{
	global $db;

	$sql = "SELECT count(*) as c
		FROM " . LIME_PREFIX . "survey_$lime_sid as s
		JOIN `case` as c ON (c.case_id = '$case_id')
		JOIN `sample` as sam ON (c.sample_id = sam.sample_id)
		WHERE s.token = c.token
		AND s.`$lime_sgqa` $comparison '$value'";

	$rs = $db->GetRow($sql);

	if (isset($rs) && !empty($rs))
		return $rs['c'];
	
	return false;
}

/**
 * Return whether the given case matches the replicate sample only quota
 * 
 * @param int $lime_sid The Limesurvey survey id
 * @param int $case_id The case id
 * @param string $val The sample value to compare
 * @param string $var The sample variable to compare
 * 
 * @return bool|int False if failed, otherwise 1 if matched, 0 if doesn't
 * @author Adam Zammit <adam.zammit@acspri.org.au>
 * @since  2012-04-30
 */
function limesurvey_quota_replicate_match($lime_sid,$case_id,$val,$var)
{
	global $db;
	
	$sql = "SELECT count(*) as c
		FROM " . LIME_PREFIX . "survey_$lime_sid as s
		JOIN `case` as c ON (c.case_id = '$case_id')
		JOIN `sample` as sam ON (c.sample_id = sam.sample_id)
		JOIN `sample_var` as sv ON (sv.sample_id = sam.sample_id AND sv.var LIKE '$var' AND sv.val LIKE '$val')
		WHERE s.token = c.token";

	$rs = $db->GetRow($sql);

	if (isset($rs) && !empty($rs))
		return $rs['c'];
	
	return false;

}

/**
 * Return the number of completions for a given
 * questionnaire, where the given question has
 * the given value
 *
 * @param string $lime_sgqa The limesurvey SGQA
 * @param int $lime_sid The limesurvey survey id 
 * @param int $questionnaire_id The questionnaire ID
 * @param int $sample_import_id The sample import ID
 * @param string $value The value to compare
 * @param string $comparison The type of comparison
 * @return bool|int False if failed, otherwise the number of completions
 * 
 */
function limesurvey_quota_completions($lime_sgqa,$lime_sid,$questionnaire_id,$sample_import_id,$value,$comparison)
{
	global $db;

	$sql = "SELECT count(*) as c
		FROM " . LIME_PREFIX . "survey_$lime_sid as s
		JOIN `case` as c ON (c.questionnaire_id = '$questionnaire_id')
		JOIN `sample` as sam ON (c.sample_id = sam.sample_id AND sam.import_id = '$sample_import_id')
		WHERE s.submitdate IS NOT NULL
		AND s.token = c.token
		AND s.`$lime_sgqa` $comparison '$value'";

	$rs = $db->GetRow($sql);


	if (isset($rs) && !empty($rs))
		return $rs['c'];
	
	return false;
}

/**
 * Get information on limesurvey quota's
 * Based on GetQuotaInformation() from common.php in Limesurvey
 *
 * @param int $lime_quota_id The quota id to get information on
 * @param string $baselang The base language for getting information from questions
 * @return array An array containing the question information for comparison
 */
function get_limesurvey_quota_info($lime_quota_id,$baselang = DEFAULT_LOCALE)
{
	global $db;

	$ret = array();

	$sql = "SELECT *
		FROM ".LIME_PREFIX."quota_members
		WHERE quota_id='$lime_quota_id'";
	
	$rs = $db->GetAll($sql);

	foreach($rs as $quota_entry)
	{
		$lime_qid = $quota_entry['qid'];
		$surveyid = $quota_entry['sid'];

		$sql = "SELECT type, title,gid
			FROM ".LIME_PREFIX."questions
			WHERE qid='$lime_qid' 
			AND language='$baselang'";

		$qtype = $db->GetRow($sql);
	
		$fieldnames = "0";
		
		if ($qtype['type'] == "I" || $qtype['type'] == "G" || $qtype['type'] == "Y")
		{
			$fieldnames= ($surveyid.'X'.$qtype['gid'].'X'.$quota_entry['qid']);
			$value = $quota_entry['code'];
		}
		
		if($qtype['type'] == "L" || $qtype['type'] == "O" || $qtype['type'] =="!") 
		{
		    $fieldnames=( $surveyid.'X'.$qtype['gid'].'X'.$quota_entry['qid']);
		    $value = $quota_entry['code'];
		}

		if($qtype['type'] == "M")
		{
			$fieldnames=( $surveyid.'X'.$qtype['gid'].'X'.$quota_entry['qid'].$quota_entry['code']);
			$value = "Y";
		}
		
		if($qtype['type'] == "A" || $qtype['type'] == "B")
		{
			$temp = explode('-',$quota_entry['code']);
			$fieldnames=( $surveyid.'X'.$qtype['gid'].'X'.$quota_entry['qid'].$temp[0]);
			$value = $temp[1];
		}
		

		$ret[] = array('code' => $quota_entry['code'], 'value' => $value, 'qid' => $quota_entry['qid'], 'fieldname' => $fieldnames);
	}

	return $ret;
}

/** 
 * Taken from common.php in the LimeSurvey package
 * Add a prefix to a database name
 *
 * @param string $name Database name
 * @link http://www.limesurvey.org/ LimeSurvey
 */
function db_table_name($name)
{
	return "`".LIME_PREFIX.$name."`";
}


/** 
 * Taken from common.php in the LimeSurvey package
 * Get a random survey ID
 *
 * @link http://www.limesurvey.org/ LimeSurvey
 */
function getRandomID()
{        // Create a random survey ID - based on code from Ken Lyle
        // Random sid/ question ID generator...
        $totalChar = 5; // number of chars in the sid
        $salt = "123456789"; // This is the char. that is possible to use
        srand((double)microtime()*1000000); // start the random generator
        $sid=""; // set the inital variable
        for ($i=0;$i<$totalChar;$i++) // loop and create sid
        $sid = $sid . substr ($salt, rand() % strlen($salt), 1);
        return $sid;
}


/**
* Creates a random sequence of characters
*
* @param mixed $length Length of resulting string
* @param string $pattern To define which characters should be in the resulting string
* 
* From Limesurvey
*/
function sRandomChars($length = 15,$pattern="23456789abcdefghijkmnpqrstuvwxyz")
{
    $patternlength = strlen($pattern)-1;
    for($i=0;$i<$length;$i++)
    {   
        if(isset($key))
            $key .= $pattern{rand(0,$patternlength)};
        else
            $key = $pattern{rand(0,$patternlength)};
    }
    return $key;
}




/** 
 * Taken from admin/database.php in the LimeSurvey package
 * With modifications
 *
 * @param string $title Questionnaire name
 * @param bool $exittoend Whether to exit to the project end, or to the start of the questionnaire
 * @link http://www.limesurvey.org/ LimeSurvey
 */
function create_limesurvey_questionnaire($title,$exittoend = true)
{
	global $db;

	// Get random ids until one is found that is not used
	do
	{
		$surveyid = getRandomID();
		$isquery = "SELECT sid FROM ".db_table_name('surveys')." WHERE sid=$surveyid";
		$isresult = $db->Execute($isquery);
	}
	while (!empty($isresult) && $isresult->RecordCount() > 0);

	$isquery = "INSERT INTO ". LIME_PREFIX ."surveys\n"
	. "(sid, owner_id, admin, active, expires, "
	. "adminemail, private, faxto, format, template, "
	. "language, datestamp, ipaddr, refurl, usecookie, notification, allowregister, "
	. "allowsave, autoredirect, allowprev,datecreated,tokenanswerspersistence)\n"
	. "VALUES ($surveyid, 1,\n"
	. "'', 'N', \n"
	. "NULL, '', 'N',\n"
	. "'', 'S', 'quexs',\n"
	. "'" . DEFAULT_LOCALE . "', 'Y', 'N', 'N',\n"
	. "'N', '0', 'Y',\n"
	. "'Y', 'Y', 'Y','".date("Y-m-d")."','Y')";
	$isresult = $db->Execute($isquery) or die ($isquery."<br/>".$db->ErrorMsg());

	// insert base language into surveys_language_settings
	$isquery = "INSERT INTO ".db_table_name('surveys_languagesettings')
	. "(surveyls_survey_id, surveyls_language, surveyls_title, surveyls_description, surveyls_welcometext, surveyls_urldescription, "
	. "surveyls_email_invite_subj, surveyls_email_invite, surveyls_email_remind_subj, surveyls_email_remind, "
	. "surveyls_email_register_subj, surveyls_email_register, surveyls_email_confirm_subj, surveyls_email_confirm,surveyls_url)\n"
	. "VALUES ($surveyid, '" . DEFAULT_LOCALE . "', $title, $title,\n"
	. "'',\n"
	. "'', '',\n"
	. "'', '',\n"
	. "'', '',\n"
	. "'', '',\n"
	. "'', '";

	if ($exittoend)
		$isquery .=  "{ENDINTERVIEWURL}')";
	else
		$isquery .=  "{STARTINTERVIEWURL}')";
	
	$isresult = $db->Execute($isquery) or die ($isquery."<br/>".$db->ErrorMsg());


	// Insert into survey_rights
	$isrquery = "INSERT INTO ". LIME_PREFIX . "surveys_rights VALUES($surveyid,1,1,1,1,1,1,1)";
	$isrresult = $db->Execute($isrquery) or die ($isrquery."<br />".$db->ErrorMsg());

	return $surveyid;
}


/**
 * Return the limesurvey id given the case_id
 *
 * @param int $case_id The case id
 * @return bool|int False if no lime_id otherwise the lime_id
 *
 */
function get_lime_id($case_id)
{
	global $db;

	$lime_sid = get_lime_sid($case_id);
	if ($lime_sid == false) return false;

	$sql = "SELECT s.id
		FROM " . LIME_PREFIX . "survey_$lime_sid as s, `case` as c
		WHERE c.case_id = '$case_id'
		AND c.token = s.token";
	
	$r = $db->GetRow($sql);

	if (!empty($r) && isset($r['id']))
		return $r['id'];

	return false;


}


/**
 * Return the limesurvey tid given the case_id
 *
 * @param int $case_id The case id
 * @return bool|int False if no lime_tid otherwise the lime_tid
 *
 */
function get_lime_tid($case_id)
{
	global $db;

	$lime_sid = get_lime_sid($case_id);
	if ($lime_sid == false) return false;

	$sql = "SELECT t.tid
		FROM " . LIME_PREFIX . "tokens_$lime_sid as t, `case` as c
		WHERE c.case_id = '$case_id'
		AND c.token = t.token";
	
	$r = $db->GetRow($sql);

	if (!empty($r) && isset($r['tid']))
		return $r['tid'];

	return false;


}

/**
 * Return the lime_sid given the case_id
 *
 * @param int $case_id The case id
 * @return bool|int False if no lime_sid otherwise the lime_sid
 *
 */
function get_lime_sid($case_id)
{
	global $db;

	$sql = "SELECT q.lime_sid
		FROM questionnaire as q, `case` as c
		WHERE c.case_id = '$case_id'
		AND q.questionnaire_id = c.questionnaire_id";

	$l = $db->GetRow($sql);

	if (empty($l)) return false;

	return $l['lime_sid'];
}

/**
 * Check if LimeSurvey has marked a questionnaire as quota filled
 *
 * @param int $case_id The case id
 * @return bool True if complete, false if not or unknown
 *
 */
function limesurvey_is_quota_full($case_id)
{
	global $db;

	$lime_sid = get_lime_sid($case_id);
	if ($lime_sid == false) return false;

	$sql = "SELECT t.completed
		FROM " . LIME_PREFIX . "tokens_$lime_sid as t, `case` as c
		WHERE c.case_id = '$case_id'
		AND c.token = t.token";
	
	$r = $db->GetRow($sql);

	if (!empty($r))
		if ($r['completed'] == 'Q') return true;

	return false;
}


/**
 * Check if LimeSurvey has marked a questionnaire as complete
 *
 * @param int $case_id The case id
 * @return bool True if complete, false if not or unknown
 *
 */
function limesurvey_is_completed($case_id)
{
	global $db;

	$lime_sid = get_lime_sid($case_id);
	if ($lime_sid == false) return false;

	$sql = "SELECT t.completed
		FROM " . LIME_PREFIX . "tokens_$lime_sid as t, `case` as c
		WHERE c.case_id = '$case_id'
		AND t.token = c.token";
	
	$r = $db->GetRow($sql);

	if (!empty($r))
		if ($r['completed'] != 'N' && $r['completed'] != 'Q') return true;

	return false;
}


/**
 * Return the number of questions in the given questionnaire
 *
 * @param int $lime_sid The limesurvey sid
 * @return bool|int False if no data, otherwise the number of questions
 *
 */
function limesurvey_get_numberofquestions($lime_sid)
{
	global $db;

	$sql = "SELECT count(qid) as c
		FROM " . LIME_PREFIX . "questions
		WHERE sid = '$lime_sid'";

	$r = $db->GetRow($sql);

	if (!empty($r))
		return $r['c'];

	return false;
}

/**
 * Return the percent complete a questionnaire is, or false if not started
 *
 * @param int $case_id The case id
 * @return bool|float False if no data, otherwise the percentage of questions answered
 *
 */
function limesurvey_percent_complete($case_id)
{
	global $db;

	$lime_sid = get_lime_sid($case_id);
	if ($lime_sid == false) return false;

	$sql = "SELECT saved_thisstep
		FROM ". LIME_PREFIX ."saved_control
		WHERE sid = '$lime_sid'
		AND identifier = '$case_id'";

	$r = $db->GetRow($sql);

	if (!empty($r))
	{
		$step = $r['saved_thisstep'];
		$questions = limesurvey_get_numberofquestions($lime_sid);
		return ($step / $questions) * 100.0;
	}

	return false;

}


function limesurvey_get_width($qid,$default)
{
	global $db;

	$sql = "SELECT value FROM ".LIME_PREFIX."question_attributes WHERE qid = '$qid' and attribute = 'maximum_chars'";
	$r = $db->GetRow($sql);

	if (!empty($r))
		$default = $r['value'];

	return $default;
}

?>
