<?php
/**
 * Session based authentication using the Limesurvey database (client)
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
 * @copyright Australian Consortium for Social and Political Research Incorporated (ACSPRI) 2013
 * @package queXS
 * @subpackage user
 * @link http://www.acspri.org.au/ queXS was writen for ACSPRI
 * @license http://opensource.org/licenses/gpl-2.0.php The GNU General Public License (GPL) Version 2
 * 
 */

/**
 * Configuration file
 */
include_once(dirname(__FILE__)."/../config.inc.php");

/**
 * Database file
 */
include_once(dirname(__FILE__)."/../db.inc.php");


//get session name from DB
//
$sql = "SELECT stg_value
        FROM " . LIME_PREFIX . "settings_global
        WHERE stg_name = 'SessionName'";

session_name($db->GetOne($sql));

//check if the session exists or loginID not set
if (session_id() == "" || !isset($_SESSION['loginID']))
{
  //need to log in
  header('Location: ../include/limesurvey/admin/admin.php');
  die();
}
