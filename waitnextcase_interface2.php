<?php 
/**
 * Display the main page including all panels and tabs
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
 * @subpackage user
 * @link http://www.deakin.edu.au/dcarf/ queXS was writen for DCARF - Deakin Computer Assisted Research Facility
 * @license http://opensource.org/licenses/gpl-2.0.php The GNU General Public License (GPL) Version 2
 * 
 *
 */
 
/**
 * Language file
 */
include_once("lang.inc.php");

/**
 * XHTML functions
 */
include_once("functions/functions.xhtml.php");

xhtml_head(T_("queXS"), false, array("css/index_interface2.css","css/tabber_interface2.css"),array("js/tabber_interface2.js"));

if (isset($_GET['auto']))
{
	include_once("functions/functions.operator.php");

	$operator_id = get_operator_id();
	$case_id = get_case_id($operator_id,false);
	end_case($operator_id);
	 //add case note  
      $sql = "INSERT INTO case_note (case_note_id,case_id,operator_id,note,`datetime`)
        VALUES (NULL,'$case_id','$operator_id','" . TQ_("Operator Automatically logged out after: ") . AUTO_LOGOUT_MINUTES . TQ_(" minutes") . "', CONVERT_TZ(NOW(),'System','UTC'))";
      $db->Execute($sql);

	print "<h1>" . T_("You have been automatically logged out of work due to inactivity") . "</h1>";
}

?>
<div id="header_line"></div>
<ul class="wait_wrapper">
	<li class="wait_li_1"><a href="index_interface2.php"><?php  echo T_("Get a new case"); ?> <img src="css/images/play.jpg" /></a></li>
    <li class="wait_li_2"><a href="endwork.php"><?php  echo T_("End work"); ?> <img src="css/images/end.jpg" /></a></li>

</ul>

<?php 

xhtml_foot();

?>
