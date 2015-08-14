<?php 
/**
 * Select and search within a sample to see what case(s) is/are assigned to a sample record
 * and if so to look at them, otherwise give the option to remove a sample record
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
 * Authentication file
 */
include ("auth-admin.php");

/**
 * XHTML functions
 */
include("../functions/functions.xhtml.php");

/**
 * Input functions
 */
include("../functions/functions.input.php");

global $db;
$css = array(
"../include/bootstrap/css/bootstrap.min.css", 
"../include/bootstrap/css/bootstrap-theme.min.css",
"../include/font-awesome/css/font-awesome.css",
/* "../include/bootgrid/jquery.bootgrid.css", */
"../include/bs-data-table/css/jquery.bdt.css",
"../css/custom.css"
			);
$js_head = array(
"../include/jquery/jquery.min.js",
"../include/bootstrap/js/bootstrap.min.js",
/* "../include/bootgrid/jquery.bootgrid.min.js", */
				);
$js_foot = array(

"../include/bs-data-table/js/vendor/jquery.sortelements.js",
"../include/bs-data-table/js/jquery.bdt.js",
"../js/window.js",
"../js/custom.js"
				);

$sample_import_id = false;
if (isset($_GET['sample_import_id'])) 	$sample_import_id = bigintval($_GET['sample_import_id']);

$subtitle = T_("Search within this sample");

xhtml_head(T_("Search the sample"),true,$css,$js_head);

?>
<div class="modal fade delete-confirm" id="delete-confirm" tabindex="-1" role="dialog" aria-labelledby="delete-confirm" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
		<div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
          <h4 class="modal-title text-danger " ><?php echo T_("WARNING !");?></h4>
        </div>
		<div class="modal-body">
			<p><?php echo T_("Are you shure you want to delete") . "&ensp;" . T_("Sample ID") . "&ensp;<b class='text-danger'>" . "</b>?";?></p>		
		</div>
	  <div class="modal-footer">
        <button type="button" class="btn btn-default pull-left" data-dismiss="modal"><?php echo T_("NOOOO...");?></button>
        <a  class="btn btn-danger" href=" "><?php echo T_("Yes"),",&ensp;",T_("Delete");?></a>
      </div>
    </div>
  </div>
</div>
<?php
echo "<a href='' onclick='history.back();return false;' class='btn btn-default pull-left' ><i class='fa fa-chevron-left text-primary'></i>&emsp;" . T_("Go back") . "</a>";

$sql = "SELECT sample_import_id as value,description, CASE WHEN sample_import_id = '$sample_import_id' THEN 'selected=\'selected\'' ELSE '' END AS selected
	FROM sample_import";
$r = $db->GetAll($sql);

if(!empty($r))

	print "<div class=' form-inline form-group col-md-6'><h4 class='control-label form-group col-sm-6 text-right'>" . T_("Select sample ") . "&emsp;</h4>";
	display_chooser($r,"sample_import_id","sample_import_id",true,false,true,false);
	
	print "</div>";

if (isset($_GET['sample_id']))
{
	//need to remove this sample record from the sample

	$sample_id = bigintval($_GET['sample_id']);

	$db->StartTrans();

	$sql = "DELETE FROM sample_var
		WHERE sample_id = '$sample_id'";
	$db->Execute($sql);

	$sql = "DELETE FROM sample
		WHERE sample_id = '$sample_id'";
	$db->Execute($sql);

	$db->CompleteTrans();
	
	print "<div class='alert alert-danger pull-left  form-group col-sm-6' role='alert'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button><p>" . T_("Sample ID") .  "&ensp;<b>" . $sample_id . "</b>&ensp;" . T_("Deleted") . ".</p></div>";
}

print "<div class='clearfix'></div>";

if ($sample_import_id != false)
{
		$sql = "SELECT sv.sample_id, CASE WHEN c.case_id IS NULL THEN 
		CONCAT('&emsp;<a href=\'\' data-toggle=\'modal\' data-target=\'.delete-confirm\' data-href=\'?sample_import_id=$sample_import_id&amp;sample_id=', sv.sample_id ,'\' data-sample_id=\' ', sv.sample_id ,' \'  class=\'\'><i data-toggle=\'tooltip\' title=\'" . TQ_("Delete sample record") . " ', sv.sample_id ,'\' class=\'fa fa-2x fa-trash-o text-danger\'></i></a>&emsp;')
		ELSE CONCAT('<a href=\'supervisor.php?case_id=', c.case_id , '\' data-toggle=\'tooltip\' title=\'" . TQ_("Assigned to case ID :") . " ', c.case_id , '\'><b>', c.case_id ,'</b></a>')
		END as link
			FROM sample_var AS sv
			JOIN (sample as s) ON (s.import_id = '$sample_import_id' and sv.sample_id = s.sample_id)
			LEFT JOIN (`case` AS c, questionnaire AS q) ON ( c.sample_id = sv.sample_id AND q.questionnaire_id = c.questionnaire_id )
			GROUP BY s.sample_id, c.case_id";
		$r = $db->GetAll($sql);
		
		if ($r) {


			$fnames = array("sample_id");
			$fdesc = array(T_("Sample id"));
			
			$fnames[] = "link";
			$fdesc[] = T_("Case ID");
			
			$sql = "SELECT var,var_id
				FROM sample_import_var_restrict
				WHERE sample_import_id = $sample_import_id
				ORDER by var ASC";
			$rs = $db->GetAll($sql);
			
			foreach($rs as $rsw)
			{
				$fnames[] = $rsw['var_id'];
				$fdesc[] = $rsw['var'];
			}
			foreach($r as &$rw)
			{
				$sql = "SELECT var_id,val
					FROM sample_var
					WHERE sample_id = {$rw['sample_id']}";
				$rs = $db->GetAll($sql);
				foreach($rs as $rsw){
					$rw[$rsw['var_id']] = $rsw['val'];
				}
			}

			print "<div class='form-group'>";
			xhtml_table($r,$fnames,$fdesc,"tclass",false,false,"bs-table");
			print "</div>";
		}
		else print "<div class='alert alert-info col-sm-6 ' role='alert'><h4>" . T_("There's no data in this sample.") .  "</h4></div>";
}
xhtml_foot($js_foot);
?>
<script type="text/javascript">
$('#bs-table').bdt();
/* $('#bs-table').bootgrid({ 
	ajax: true,
	post: "$sample_import_id",
	url: "?sample_import_id=\"$sample_import_id\"",
 }); */
	
$('#delete-confirm').on('show.bs.modal', function (event) {
  var a = $(event.relatedTarget)
  var href = a.data('href') 
  var sample_id =a.data('sample_id')
  var modal = $(this)
  modal.find('.modal-body p b').text( +sample_id )
  modal.find('.modal-footer a').attr('href', href)
})
</script>
