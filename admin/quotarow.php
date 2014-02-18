<?php 
/**
 * Set quota's for answered questions and be able to exclude sample records by row 
 * instead of an entire sample
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
 * @copyright Deakin University 2007,2008,2009
 * @package queXS
 * @subpackage admin
 * @link http://www.deakin.edu.au/dcarf/ queXS was writen for DCARF - Deakin Computer Assisted Research Facility
 * @license http://opensource.org/licenses/gpl-2.0.php The GNU General Public License (GPL) Version 2
 * 
 *
 */

/**
 * Configuration file
 */
include("../config.inc.php");

/**
 * Database file
 */
include ("../db.inc.php");

/**
 * XHTML functions
 */
include("../functions/functions.xhtml.php");

/**
 * Display functions
 */
include("../functions/functions.display.php");

/**
 * Input functions
 */
include("../functions/functions.input.php");

/**
 * Limesurvey functions
 */
include("../functions/functions.limesurvey.php");

/**
 * Operator functions
 */
include("../functions/functions.operator.php");


global $db;

if (isset($_POST['add_quota']))
{
	//need to add quota
	$completions = intval($_POST['completions']);
	$autoprioritise = 0;
	if (isset($_POST['autoprioritise'])) $autoprioritise = 1;
	$priority = intval($_POST['priority']);
	$questionnaire_id = bigintval($_GET['questionnaire_id']);
  $sample_import_id = bigintval($_GET['sample_import_id']);
	$description = $db->quote($_POST['description']);

	$sql = "INSERT INTO questionnaire_sample_quota_row(questionnaire_id, sample_import_id, completions, description, priority, autoprioritise)
		VALUES ($questionnaire_id, $sample_import_id, $completions, $description, $priority, $autoprioritise)";

	$db->Execute($sql);

	//Make sure to calculate on the spot
	//update_quotas($questionnaire_id);
}


$qsqri = false;
$qsqrid = false;
if (isset($_GET['qsqri']) & isset($_GET['edit']))
{
  $qsqri = bigintval($_GET['qsqri']);

  $sql = "SELECT questionnaire_id,sample_import_id,description
          FROM questionnaire_sample_quota_row
          WHERE questionnaire_sample_quota_row_id = $qsqri";

  $rs = $db->GetRow($sql);

  $_GET['questionnaire_id'] = $rs['questionnaire_id'];
  $_GET['sample_import_id'] = $rs['sample_import_id'];
  $qsqrid = $rs['description'];
}

$questionnaire_id = false;
if (isset($_GET['questionnaire_id'])) 	$questionnaire_id = bigintval($_GET['questionnaire_id']);

xhtml_head(T_("Quota row management"),true,array("../css/table.css"),array("../js/window.js"));
print "<h1>" . T_("Select a questionnaire from the list below") . "</h1>";

$sql = "SELECT questionnaire_id as value,description, CASE WHEN questionnaire_id = '$questionnaire_id' THEN 'selected=\'selected\'' ELSE '' END AS selected
 	FROM questionnaire
	WHERE enabled = 1";
display_chooser($db->GetAll($sql),"questionnaire","questionnaire_id");


if ($questionnaire_id != false)
{
	$sample_import_id = false;
	if (isset($_GET['sample_import_id'])) 	$sample_import_id = bigintval($_GET['sample_import_id']);

	print "<h1>" . T_("Select a sample from the list below") . "</h1>";
	
	$sql = "SELECT s.sample_import_id as value,s.description, CASE WHEN s.sample_import_id = '$sample_import_id' THEN 'selected=\'selected\'' ELSE '' END AS selected
	 	FROM sample_import as s, questionnaire_sample as q
		WHERE q.questionnaire_id = $questionnaire_id
		AND q.sample_import_id = s.sample_import_id";

	display_chooser($db->GetAll($sql),"sample","sample_import_id",true,"questionnaire_id=$questionnaire_id");

	if ($sample_import_id != false)
  {
    if ($qsqri != false)
    {
      print "<h2>" . T_("Quota") . ": $qsqrid</h2>";
      print "<p><a href='?questionnaire_id=$questionnaire_id&amp;sample_import_id=$sample_import_id'>" . T_("Go back") . "</a></p>";
  
      print "<h2>" . T_("Edit row quota") . "</h2>";
      ?>
      <form action="?<?php echo "questionnaire_id=$questionnaire_id&amp;sample_import_id=$sample_import_id"; ?>" method="post">
				<p>
				<label for="description"><?php  echo T_("Describe this quota"); ?> </label><input type="text" name="description" id="description"/>		<br/>
				<label for="priority"><?php  echo T_("Quota priority (50 is default, 100 highest, 0 lowest)"); ?> </label><input type="text" name="priority" id="priority" value="50"/>		<br/>
				<label for="autoprioritise"><?php  echo T_("Should the priority be automatically updated based on the number of completions in this quota?"); ?> </label><input type="checkbox" name="autoprioritise" id="autoprioritise"/>		<br/>
        <label for="completions"><?php  echo T_("The number of completions to stop calling at"); ?> </label><input type="text" name="completions" id="completions"/>		<br/>
        <input type="hidden" name="qsqri" value="<?php echo $qsqri; ?>"/>
				<input type="submit" name="edit_quota" value="<?php  print(T_("Edit row quota")); ?>"/></p>
      </form>
      <?php

      //display questionnaire references
      $sql = "SELECT qsqr_question_id,lime_sgqa,value,comparison,description,
              CONCAT('<a href=\'?delete=delete&amp;qsqrqi=', qsqr_question_id, '\'>" . TQ_("Delete") .  "</a>') as qdelete
              FROM qsqr_question
              WHERE questionnaire_sample_quota_row_id = $qsqri";

      
      $rs = $db->GetAll($sql);

      if (empty($rs))
      {
        print "<h3>" . T_("All completed responses will be counted") . "</h3>";
      }
      else
      {
        print "<h3>" . T_("Only completed responses that have answered the following will be counted") . "</h3>";
        xhtml_table($rs,array('lime_sgqa','comparison','value','qdelete'),array(T_("Question"),T_("Comparison"),T_("Value"),T_("Delete")));
      }

      //add questionnaire references if any (refer to sample only or count completions based on responses to questions)

      $sql = "SELECT lime_sid 
              FROM questionnaire
              WHERE questionnaire_id = $questionnaire_id";

      $lime_sid = $db->GetOne($sql);

      //select question
  		$sql = "SELECT CONCAT( lq.sid, 'X', lq.gid, 'X', CASE WHEN lq.parent_qid = 0 THEN lq.qid ELSE CONCAT(lq.parent_qid, lq.title) END) as value, CASE WHEN lq.parent_qid = 0 THEN lq.question ELSE CONCAT(lq2.question, ': ', lq.question) END as description, '' AS selected
	  		FROM `" . LIME_PREFIX . "questions` AS lq
  			LEFT JOIN `" . LIME_PREFIX . "questions` AS lq2 ON ( lq2.qid = lq.parent_qid )
  			JOIN `" . LIME_PREFIX . "groups` as g ON (g.gid = lq.gid)
  			WHERE lq.sid = '$lime_sid'
  			ORDER BY g.group_order ASC, lq.question_order ASC";

	  	$rs = $db->GetAll($sql);
  
      if (!empty($rs))
      {
        print "<h4>" . T_("Add restriction based on answered questions") . "</h4>";
        print "<label for='sgqa'>" . T_("Question") . "</label>";
        display_chooser($rs,"sgqa","sgqa",false,"qsqri=$qsqri",false,false);
        ?>
        <br/><label for="comparison"><?php  echo T_("The type of comparison"); ?></label><select name="comparison" id="comparison"><option value="LIKE">LIKE</option><option value="NOT LIKE">NOT LIKE</option><option value="=">=</option><option value="!=">!=</option><option value="&lt;">&lt;</option><option value="&gt;">&gt;</option><option value="&lt;=">&lt;=</option><option value="&gt;=">&gt;=</option></select><br/>
  			<label for="value"><?php  echo T_("The code value to compare"); ?> </label><input type="text" name="value" id="value"/>		<br/>
        <input type="submit" name="addq" value="<?php echo TQ_("Add restriction") ?>"/>
        <?php
      }

      //list sample records to exclude

      $sql = "SELECT qsqr_sample_id,exclude_var,exclude_val,comparison,description,
              CONCAT('<a href=\'?delete=delete&amp;qsqrsi=',qsqr_sample_id,'\'>" . TQ_("Delete") .  "</a>') as sdelete
              FROM qsqr_sample
              WHERE questionnaire_sample_quota_row_id = $qsqri";

      $rs = $db->GetAll($sql);

      if (empty($rs))
      {
        print "<h3>" . T_("All sample records will be counted") . "</h3>";
      }
      else
      {
        print "<h3>" . T_("Only completed responses that have the following sample details will be counted") . "</h3>";
        xhtml_table($rs,array('exclude_var','comparison','exclude_val','sdelete'),array(T_("Sample record"),T_("Comparison"),T_("Value"),T_("Delete")));
      }


      //add sample references (records from sample to exclude when quota reached)
			$sql = "SELECT sv.var as value, sv.var as description, '' AS selected
      				FROM sample_var AS sv, sample AS s
      				WHERE s.import_id = $sample_import_id
      				AND s.sample_id = sv.sample_id
              GROUP BY sv.var";

      $rs = $db->GetAll($sql);

      if (!empty($rs))
      {
        print "<h4>" . T_("Add restriction based on sample records") . "</h4>";
        print "<label for='sample_var'>" . T_("Sample record") . "</label>";
			  display_chooser($db->GetAll($sql),"sample_var","sample_var",false,"qsqri=$qsqri",false,false);
        ?>
        <br/><label for="comparisons"><?php  echo T_("The type of comparison"); ?></label><select name="comparisons" id="comparisons"><option value="LIKE">LIKE</option><option value="NOT LIKE">NOT LIKE</option><option value="=">=</option><option value="!=">!=</option><option value="&lt;">&lt;</option><option value="&gt;">&gt;</option><option value="&lt;=">&lt;=</option><option value="&gt;=">&gt;=</option></select><br/>
    		<label for="exclude_val"><?php  echo T_("Value"); ?></label>
				<?php 
				
				$sql = "SELECT sv.val as value, sv.val as description, ''  AS selected
					FROM sample_var AS sv, sample AS s
					WHERE s.import_id = $sample_import_id
					AND s.sample_id = sv.sample_id
					AND sv.var = '$sample_var'
					GROUP BY sv.val";

				display_chooser($db->GetAll($sql),"exclude_val","exclude_val",false,false,false,false);
				flush();
		    ?>
        <br/><input type="submit" name="adds" value="<?php echo TQ_("Add restriction") ?>"/>
        <?php
      }
    }
    else
    {


		print "<h1>" . T_("Current row quotas (click to edit)") . "</h1>";


    $sql = "SELECT questionnaire_sample_quota_row_id,qsq.description,
            CONCAT('<a href=\'?edit=edit&amp;qsqri=',questionnaire_sample_quota_row_id,'\'>', qsq.description, '</a>') as qedit,
            CONCAT('<input type=\'checkbox\' name=\'select_',questionnaire_sample_quota_row_id,'\'/>') as qselect,
            qsq.completions,qsq.quota_reached,qsq.current_completions
            FROM questionnaire_sample_quota_row as qsq, questionnaire as q
      			WHERE qsq.questionnaire_id = '$questionnaire_id'
      			AND qsq.sample_import_id = '$sample_import_id'
      			AND q.questionnaire_id = '$questionnaire_id'";
	
		$r = $db->GetAll($sql);

   print "<form method='post' action='?questionnaire_id=$questionnaire_id&amp;sample_import_id=$sample_import_id'>";
		if (empty($r))
		{
			print "<p>" . T_("Currently no row quotas") . "</p>";
		}
		else
		{
       xhtml_table($r,array('qedit','completions','current_completions','qselect'),array(T_("Description"),T_("Quota"),T_("Completions"),T_("Select")));
       print "<input type='submit' name='submitdelete' value='" . TQ_("Delete selected") . "'/>";
       print "<input type='submit' name='submitexport' value='" . TQ_("Export selected") . "'/>";

    //select sample

	    }
    print "</form>";
    print "<h2>" . T_("Add row quota") . "</h2>";
    ?>
      <form action="?<?php echo "questionnaire_id=$questionnaire_id&amp;sample_import_id=$sample_import_id"; ?>" method="post">
				<p>
				<label for="description"><?php  echo T_("Describe this quota"); ?> </label><input type="text" name="description" id="description"/>		<br/>
				<label for="priority"><?php  echo T_("Quota priority (50 is default, 100 highest, 0 lowest)"); ?> </label><input type="text" name="priority" id="priority" value="50"/>		<br/>
				<label for="autoprioritise"><?php  echo T_("Should the priority be automatically updated based on the number of completions in this quota?"); ?> </label><input type="checkbox" name="autoprioritise" id="autoprioritise"/>		<br/>
        <label for="completions"><?php  echo T_("The number of completions to stop calling at"); ?> </label><input type="text" name="completions" id="completions"/>		<br/>
				<input type="submit" name="add_quota" value="<?php  print(T_("Add row quota")); ?>"/></p>
    </form>
    <?php
    }
  }
}
xhtml_foot();


?>
