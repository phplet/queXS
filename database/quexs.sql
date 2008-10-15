-- phpMyAdmin SQL Dump
-- version 2.11.2.2
-- http://www.phpmyadmin.net
--
-- Host: databasedev.dcarf
-- Generation Time: Jul 24, 2008 at 11:07 AM
-- Server version: 5.0.32
-- PHP Version: 5.2.0-8+etch11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `quexs`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointment_id` bigint(20) NOT NULL auto_increment,
  `case_id` bigint(20) NOT NULL,
  `contact_phone_id` bigint(20) NOT NULL,
  `call_attempt_id` bigint(20) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `require_operator_id` bigint(20) default NULL,
  `respondent_id` bigint(20) NOT NULL,
  `completed_call_id` bigint(20) default NULL,
  PRIMARY KEY  (`appointment_id`),
  KEY `completed_call_id` (`completed_call_id`),
  KEY `call_attempt_id` (`call_attempt_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `appointment`
--


-- --------------------------------------------------------

--
-- Table structure for table `call`
--

CREATE TABLE `call` (
  `call_id` bigint(20) NOT NULL auto_increment,
  `operator_id` bigint(20) NOT NULL,
  `respondent_id` bigint(20) NOT NULL,
  `case_id` bigint(20) NOT NULL,
  `contact_phone_id` bigint(20) NOT NULL,
  `call_attempt_id` bigint(20) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime default NULL,
  `outcome_id` int(11) NOT NULL default '0',
  `state` tinyint(1) NOT NULL default '0' COMMENT '0 not called, 1 requesting call, 2 ringing, 3 answered, 4 requires coding, 5 done',
  PRIMARY KEY  (`call_id`),
  KEY `operator_id` (`operator_id`),
  KEY `case_id` (`case_id`),
  KEY `call_attempt_id` (`call_attempt_id`),
  KEY `contact_phone_id` (`contact_phone_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `call`
--


-- --------------------------------------------------------

--
-- Table structure for table `call_attempt`
--

CREATE TABLE `call_attempt` (
  `call_attempt_id` bigint(20) NOT NULL auto_increment,
  `case_id` bigint(20) NOT NULL,
  `operator_id` bigint(20) NOT NULL,
  `respondent_id` bigint(20) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime default NULL,
  PRIMARY KEY  (`call_attempt_id`),
  KEY `case_id` (`case_id`),
  KEY `end` (`end`),
  KEY `respondent_id` (`respondent_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `call_attempt`
--


-- --------------------------------------------------------

--
-- Table structure for table `call_note`
--

CREATE TABLE `call_note` (
  `call_note_id` bigint(20) NOT NULL auto_increment,
  `call_id` bigint(20) NOT NULL,
  `operator_id` bigint(20) NOT NULL,
  `note` text NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY  (`call_note_id`),
  KEY `call_id` (`call_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `call_note`
--


-- --------------------------------------------------------

--
-- Table structure for table `call_restrict`
--

CREATE TABLE `call_restrict` (
  `day_of_week` tinyint(1) NOT NULL,
  `start` time NOT NULL,
  `end` time NOT NULL,
  KEY `day_of_week` (`day_of_week`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `call_restrict`
--

INSERT INTO `call_restrict` VALUES(1, '09:00:00', '17:00:00');
INSERT INTO `call_restrict` VALUES(2, '09:00:00', '20:30:00');
INSERT INTO `call_restrict` VALUES(3, '09:00:00', '20:30:00');
INSERT INTO `call_restrict` VALUES(4, '09:00:00', '20:30:00');
INSERT INTO `call_restrict` VALUES(5, '09:00:00', '20:30:00');
INSERT INTO `call_restrict` VALUES(6, '09:00:00', '20:30:00');
INSERT INTO `call_restrict` VALUES(7, '09:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `call_state`
--

CREATE TABLE `call_state` (
  `call_state_id` tinyint(1) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY  (`call_state_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `call_state`
--

INSERT INTO `call_state` VALUES(0, 'Not called');
INSERT INTO `call_state` VALUES(1, 'Requesting call');
INSERT INTO `call_state` VALUES(2, 'Ringing');
INSERT INTO `call_state` VALUES(3, 'Answered');
INSERT INTO `call_state` VALUES(4, 'Requires coding');
INSERT INTO `call_state` VALUES(5, 'Done');

-- --------------------------------------------------------

--
-- Table structure for table `case`
--

CREATE TABLE `case` (
  `case_id` bigint(20) NOT NULL auto_increment,
  `sample_id` bigint(20) NOT NULL,
  `questionnaire_id` bigint(20) NOT NULL,
  `last_call_id` bigint(20) default NULL,
  `current_operator_id` bigint(20) default NULL,
  `current_call_id` bigint(20) default NULL,
  `current_outcome_id` int(11) NOT NULL default '1',
  PRIMARY KEY  (`case_id`),
  UNIQUE KEY `onecasepersample` (`sample_id`,`questionnaire_id`),
  UNIQUE KEY `current_operator_id` (`current_operator_id`),
  UNIQUE KEY `current_call_id` (`current_call_id`),
  KEY `sample_id` (`sample_id`),
  KEY `questionnaire_id` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;


--
-- Dumping data for table `case`
--


-- --------------------------------------------------------

--
-- Table structure for table `case_note`
--

CREATE TABLE `case_note` (
  `case_note_id` bigint(20) NOT NULL auto_increment,
  `case_id` bigint(20) NOT NULL,
  `operator_id` bigint(20) NOT NULL,
  `note` text NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY  (`case_note_id`),
  KEY `case_id` (`case_id`),
  KEY `operator_id` (`operator_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `case_note`
--


-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `client_id` bigint(20) NOT NULL auto_increment,
  `username` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `Time_zone_name` char(64) NOT NULL,
  PRIMARY KEY  (`client_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `client`
--

-- --------------------------------------------------------

--
-- Table structure for table `client_questionnaire`
--

CREATE TABLE `client_questionnaire` (
  `client_id` bigint(20) NOT NULL,
  `questionnaire_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`client_id`,`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `client_questionnaire`
--


-- --------------------------------------------------------

--
-- Table structure for table `contact_phone`
--

CREATE TABLE `contact_phone` (
  `contact_phone_id` bigint(20) NOT NULL auto_increment,
  `case_id` bigint(20) NOT NULL,
  `priority` tinyint(1) NOT NULL default '1',
  `phone` bigint(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY  (`contact_phone_id`),
  KEY `case_id` (`case_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `contact_phone`
--


-- --------------------------------------------------------

--
-- Table structure for table `operator`
--

CREATE TABLE `operator` (
  `operator_id` bigint(20) NOT NULL auto_increment,
  `username` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `Time_zone_name` char(64) NOT NULL,
  `enabled` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`operator_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `extension` (`extension`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `operator`
--

-- --------------------------------------------------------

--
-- Table structure for table `operator_questionnaire`
--

CREATE TABLE `operator_questionnaire` (
  `operator_id` bigint(20) NOT NULL,
  `questionnaire_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`operator_id`,`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `operator_questionnaire`
--


-- --------------------------------------------------------

--
-- Table structure for table `operator_skill`
--

CREATE TABLE `operator_skill` (
  `operator_id` bigint(20) NOT NULL,
  `outcome_type_id` int(11) NOT NULL,
  PRIMARY KEY  (`operator_id`,`outcome_type_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `operator_skill`
--


-- --------------------------------------------------------

--
-- Table structure for table `outcome`
--

CREATE TABLE `outcome` (
  `outcome_id` int(11) NOT NULL auto_increment,
  `aapor_id` char(6) NOT NULL,
  `description` varchar(255) NOT NULL,
  `default_delay_minutes` bigint(20) NOT NULL,
  `outcome_type_id` int(11) NOT NULL default '1',
  `tryanother` tinyint(1) NOT NULL default '1' COMMENT 'Whether to try the next number on the list',
  `contacted` tinyint(1) NOT NULL default '1' COMMENT 'Whether a person was contacted',
  `tryagain` tinyint(1) NOT NULL default '1' COMMENT 'Whether to try this number ever again',
  `eligible` tinyint(1) NOT NULL default '1' COMMENT 'If the respondent is eligible to participate',
  `require_note` tinyint(1) NOT NULL default '0' COMMENT 'Whether to require a note to be entered',
  `calc` char(2) NOT NULL,
  PRIMARY KEY  (`outcome_id`),
  KEY `calc` (`calc`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `outcome`
--

INSERT INTO `outcome` VALUES(1, '3.11', 'Not attempted or worked', 0, 1, 1, 0, 1, 0, 0, 'UH');
INSERT INTO `outcome` VALUES(2, '3.13', 'No answer', 180, 1, 1, 0, 1, 1, 0, 'UH');
INSERT INTO `outcome` VALUES(3, '3.16', 'Technical phone problems', 180, 1, 1, 0, 1, 0, 0, 'UH');
INSERT INTO `outcome` VALUES(4, '2.34', 'Other, Referred to Supervisor (Eligible)', 0, 2, 0, 1, 1, 1, 1, 'O');
INSERT INTO `outcome` VALUES(5, '3.91', 'Other, Referred to Supervisor (Unknown eligibility)', 0, 2, 0, 0, 1, 0, 1, 'UO');
INSERT INTO `outcome` VALUES(6, '2.111a', 'Soft Refusal, Other', 10080, 3, 0, 1, 1, 1, 1, 'R');
INSERT INTO `outcome` VALUES(7, '2.111b', 'Hard Refusal, Other', 10080, 3, 0, 1, 1, 1, 1, 'R');
INSERT INTO `outcome` VALUES(8, '2.112a', 'Soft Refusal, Respondent', 10080, 3, 0, 1, 1, 1, 1, 'R');
INSERT INTO `outcome` VALUES(9, '2.112b', 'Hard Refusal, Respondent', 10080, 3, 0, 1, 1, 1, 1, 'R');
INSERT INTO `outcome` VALUES(10, '1.1', 'Complete', 0, 4, 0, 1, 1, 1, 0, 'I');
INSERT INTO `outcome` VALUES(11, '2.112', 'Known respondent refusal', 0, 4, 0, 1, 1, 1, 0, 'R');
INSERT INTO `outcome` VALUES(12, '2.111', 'Household-level refusal', 0, 4, 0, 1, 1, 1, 0, 'R');
INSERT INTO `outcome` VALUES(13, '2.112c', 'Broken appointment (Implicit refusal)', 10080, 3, 1, 0, 1, 1, 0, 'R');
INSERT INTO `outcome` VALUES(14, '4.32', 'Disconnected number', 0, 4, 1, 0, 0, 0, 0, '');
INSERT INTO `outcome` VALUES(15, '4.20', 'Fax/data line', 0, 4, 1, 1, 0, 0, 0, '');
INSERT INTO `outcome` VALUES(16, '4.51', 'Business, government office, other organization', 0, 4, 1, 1, 0, 0, 0, '');
INSERT INTO `outcome` VALUES(17, '4.70', 'No eligible respondent', 0, 4, 1, 1, 0, 0, 0, '');
INSERT INTO `outcome` VALUES(18, '2.35a', 'Accidental hang up or temporary phone problem', 0, 1, 1, 1, 1, 1, 0, 'O');
INSERT INTO `outcome` VALUES(19, '2.12a', 'Definite Appointment - Respondent', 0, 5, 0, 1, 1, 1, 0, 'R');
INSERT INTO `outcome` VALUES(20, '2.12b', 'Definite Appointment - Other', 0, 5, 0, 1, 1, 1, 0, 'R');
INSERT INTO `outcome` VALUES(21, '2.13a', 'Unspecified Appointment - Respondent', 0, 5, 0, 1, 1, 1, 0, 'R');
INSERT INTO `outcome` VALUES(22, '2.13b', 'Unspecified Appointment - Other', 0, 5, 0, 1, 1, 1, 0, 'R');
INSERT INTO `outcome` VALUES(23, '2.221', 'Household answering machine - Message left', 180, 1, 1, 1, 1, 1, 0, 'NC');
INSERT INTO `outcome` VALUES(24, '2.222', 'Household answering machine - No message left', 180, 1, 1, 1, 1, 1, 0, 'NC');
INSERT INTO `outcome` VALUES(25, '2.31', 'Respondent Dead', 0, 4, 0, 1, 0, 1, 0, 'O');
INSERT INTO `outcome` VALUES(26, '2.32', 'Physically or mentally unable/incompetent', 0, 4, 0, 1, 0, 1, 0, 'O');
INSERT INTO `outcome` VALUES(27, '2.331', 'Household level language problem', 0, 4, 1, 1, 0, 1, 0, 'O');
INSERT INTO `outcome` VALUES(28, '2.332', 'Respondent language problem', 0, 4, 0, 1, 0, 1, 0, 'O');
INSERT INTO `outcome` VALUES(29, '3.14', 'Answering machine - Not a household', 0, 4, 1, 1, 0, 0, 0, 'UH');
INSERT INTO `outcome` VALUES(30, '4.10', 'Out of sample', 0, 4, 0, 1, 0, 0, 0, '');
INSERT INTO `outcome` VALUES(31, '2.20', 'Non contact', 180, 1, 1, 1, 1, 1, 0, 'NC');

-- --------------------------------------------------------

--
-- Table structure for table `outcome_type`
--

CREATE TABLE `outcome_type` (
  `outcome_type_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY  (`outcome_type_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `outcome_type`
--

INSERT INTO `outcome_type` VALUES(1, 'Temporary Outcomes (normal cases)');
INSERT INTO `outcome_type` VALUES(2, 'Supervisor Outcomes (referred to supervisor)');
INSERT INTO `outcome_type` VALUES(3, 'Refusal Outcomes (respondent refused)');
INSERT INTO `outcome_type` VALUES(4, 'Final Outcomes (completed, final refusal, etc)');
INSERT INTO `outcome_type` VALUES(5, 'Appointments');

-- --------------------------------------------------------

--
-- Table structure for table `questionnaire`
--

CREATE TABLE `questionnaire` (
  `questionnaire_id` bigint(20) NOT NULL auto_increment,
  `description` varchar(255) NOT NULL,
  `lime_sid` int(11) NOT NULL,
  `restrict_appointments_shifts` tinyint(1) NOT NULL default '1',
  `restrict_work_shifts` tinyint(1) NOT NULL default '1',
  `testing` tinyint(1) NOT NULL default '0' COMMENT 'Whether this questionnaire is just for testing',
  `respondent_selection` tinyint(1) NOT NULL default '1',
  `rs_intro` varchar(1024) NOT NULL,
  `rs_project_intro` varchar(1024) NOT NULL,
  `rs_project_end` varchar(1024) NOT NULL,
  `rs_callback` varchar(1024) NOT NULL,
  `rs_answeringmachine` varchar(1024) NOT NULL,
  PRIMARY KEY  (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `questionnaire`
--


-- --------------------------------------------------------

--
-- Table structure for table `questionnaire_prefill`
--

CREATE TABLE `questionnaire_prefill` (
  `questionnaire_prefill_id` bigint(20) NOT NULL auto_increment,
  `questionnaire_id` bigint(20) NOT NULL,
  `lime_sgqa` varchar(255) collate utf8_unicode_ci NOT NULL,
  `value` varchar(2048) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`questionnaire_prefill_id`),
  KEY `questionnaire_id` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Table structure for table `questionnaire_sample`
--

CREATE TABLE `questionnaire_sample` (
  `questionnaire_id` bigint(20) NOT NULL,
  `sample_import_id` bigint(20) NOT NULL,
  `call_max` int(11) NOT NULL default '0',
  `call_attempt_max` int(11) NOT NULL default '0',
  `random_select` tinyint(1) NOT NULL default '0',
  `answering_machine_messages` int(11) NOT NULL default '1',
  PRIMARY KEY  (`questionnaire_id`,`sample_import_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `questionnaire_sample`
--


-- --------------------------------------------------------

--
-- Table structure for table `respondent`
--

CREATE TABLE `respondent` (
  `respondent_id` bigint(20) NOT NULL auto_increment,
  `case_id` bigint(20) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `Time_zone_name` char(64) NOT NULL,
  PRIMARY KEY  (`respondent_id`),
  KEY `case_id` (`case_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `respondent`
--


-- --------------------------------------------------------

--
-- Table structure for table `respondent_not_available`
--

CREATE TABLE `respondent_not_available` (
  `respondent_not_available_id` bigint(20) NOT NULL auto_increment,
  `respondent_id` bigint(20) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY  (`respondent_not_available_id`),
  KEY `respondent_id` (`respondent_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `respondent_not_available`
--


-- --------------------------------------------------------

--
-- Table structure for table `sample`
--

CREATE TABLE `sample` (
  `sample_id` bigint(20) NOT NULL auto_increment,
  `import_id` bigint(20) NOT NULL,
  `Time_zone_name` char(64) NOT NULL,
  `phone` char(30) NOT NULL,
  PRIMARY KEY  (`sample_id`),
  KEY `import_id` (`import_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `sample`
--


-- --------------------------------------------------------

--
-- Table structure for table `sample_import`
--

CREATE TABLE `sample_import` (
  `sample_import_id` bigint(20) NOT NULL auto_increment,
  `description` varchar(255) NOT NULL,
  `call_restrict` tinyint(1) NOT NULL default '1',
  `refusal_conversion` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`sample_import_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `sample_import`
--

-- --------------------------------------------------------

--
-- Table structure for table `sample_postcode_timezone`
--

CREATE TABLE `sample_postcode_timezone` (
  `val` int(4) NOT NULL,
  `Time_zone_name` char(64) NOT NULL,
  PRIMARY KEY  (`val`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `sample_postcode_timezone`
--

INSERT INTO `sample_postcode_timezone` VALUES(200, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(221, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(800, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(801, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(804, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(810, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(811, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(812, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(813, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(814, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(815, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(820, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(821, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(822, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(828, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(829, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(830, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(831, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(832, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(835, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(836, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(837, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(838, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(840, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(841, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(845, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(846, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(847, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(850, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(851, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(852, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(853, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(854, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(860, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(861, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(862, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(870, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(871, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(872, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(880, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(881, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(885, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(886, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(906, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(907, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(909, 'Australia/Darwin');
INSERT INTO `sample_postcode_timezone` VALUES(1001, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1002, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1003, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1004, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1005, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1006, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1007, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1008, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1009, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1010, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1011, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1020, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1021, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1022, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1023, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1025, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1026, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1027, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1028, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1029, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1030, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1031, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1032, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1033, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1034, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1035, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1036, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1037, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1038, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1039, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1040, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1041, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1042, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1043, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1044, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1045, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1046, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1100, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1101, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1105, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1106, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1107, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1108, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1109, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1110, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1112, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1113, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1114, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1115, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1116, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1117, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1118, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1119, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1120, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1121, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1122, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1123, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1124, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1125, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1126, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1127, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1128, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1129, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1130, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1131, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1132, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1133, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1134, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1135, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1136, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1137, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1138, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1139, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1140, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1141, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1142, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1143, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1144, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1145, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1146, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1147, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1148, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1149, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1150, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1151, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1152, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1153, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1154, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1155, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1156, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1157, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1158, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1159, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1160, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1161, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1162, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1163, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1164, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1165, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1166, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1167, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1168, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1169, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1170, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1171, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1172, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1173, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1174, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1175, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1176, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1177, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1178, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1179, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1180, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1181, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1182, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1183, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1184, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1185, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1186, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1187, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1188, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1189, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1190, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1191, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1192, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1193, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1194, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1195, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1196, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1197, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1198, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1199, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1200, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1201, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1202, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1203, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1204, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1205, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1206, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1207, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1208, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1209, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1210, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1211, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1212, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1213, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1214, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1215, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1216, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1217, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1218, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1219, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1220, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1221, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1222, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1223, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1224, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1225, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1226, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1227, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1228, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1229, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1230, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1231, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1232, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1233, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1234, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1235, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1236, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1237, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1238, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1239, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1240, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1291, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1292, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1293, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1294, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1295, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1296, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1297, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1298, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1299, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1300, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1311, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1312, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1313, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1314, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1315, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1316, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1317, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1318, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1319, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1320, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1321, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1322, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1323, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1324, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1325, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1326, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1327, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1328, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1329, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1330, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1331, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1332, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1333, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1334, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1335, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1340, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1350, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1355, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1360, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1391, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1401, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1416, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1419, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1420, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1422, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1423, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1424, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1425, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1426, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1427, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1428, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1429, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1430, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1435, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1440, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1441, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1445, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1450, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1455, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1460, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1465, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1466, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1470, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1475, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1476, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1480, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1481, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1484, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1485, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1487, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1490, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1493, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1495, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1499, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1515, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1560, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1565, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1570, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1582, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1585, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1590, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1595, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1597, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1602, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1608, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1610, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1611, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1630, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1635, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1639, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1640, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1655, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1658, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1660, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1670, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1675, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1680, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1685, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1690, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1691, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1692, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1693, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1694, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1695, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1696, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1697, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1698, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1699, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1700, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1701, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1710, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1712, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1715, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1730, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1740, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1741, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1750, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1755, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1765, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1771, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1781, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1790, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1797, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1800, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1805, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1811, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1816, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1819, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1825, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1826, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1830, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1831, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1835, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1848, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1851, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1860, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1871, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1875, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1885, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1888, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1890, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1891, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1900, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(1902, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2000, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2001, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2002, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2004, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2006, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2007, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2008, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2009, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2010, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2011, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2012, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2013, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2015, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2016, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2017, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2018, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2019, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2020, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2021, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2022, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2023, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2024, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2025, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2026, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2027, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2028, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2029, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2030, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2031, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2032, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2033, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2034, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2035, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2036, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2037, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2038, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2039, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2040, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2041, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2042, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2043, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2044, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2045, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2046, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2047, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2048, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2049, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2050, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2052, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2055, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2057, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2058, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2059, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2060, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2061, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2062, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2063, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2064, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2065, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2066, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2067, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2068, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2069, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2070, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2071, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2072, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2073, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2074, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2075, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2076, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2077, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2079, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2080, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2081, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2082, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2083, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2084, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2085, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2086, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2087, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2088, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2089, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2090, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2091, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2092, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2093, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2094, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2095, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2096, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2097, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2099, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2100, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2101, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2102, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2103, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2104, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2105, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2106, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2107, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2108, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2109, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2110, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2111, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2112, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2113, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2114, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2115, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2116, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2117, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2118, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2119, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2120, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2121, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2122, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2123, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2124, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2125, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2126, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2127, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2128, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2129, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2130, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2131, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2132, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2133, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2134, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2135, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2136, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2137, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2138, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2139, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2140, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2141, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2142, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2143, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2144, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2145, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2146, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2147, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2148, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2150, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2151, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2152, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2153, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2154, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2155, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2156, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2157, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2158, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2159, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2160, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2161, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2162, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2163, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2164, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2165, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2166, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2167, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2168, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2170, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2171, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2172, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2173, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2174, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2175, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2176, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2177, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2178, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2179, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2190, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2191, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2192, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2193, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2194, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2195, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2196, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2197, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2198, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2199, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2200, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2203, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2204, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2205, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2206, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2207, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2208, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2209, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2210, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2211, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2212, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2213, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2214, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2216, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2217, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2218, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2219, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2220, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2221, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2222, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2223, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2224, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2225, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2226, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2227, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2228, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2229, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2230, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2231, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2232, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2233, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2234, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2250, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2251, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2252, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2256, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2257, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2258, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2259, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2260, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2261, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2262, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2263, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2264, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2265, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2267, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2278, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2280, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2281, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2282, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2283, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2284, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2285, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2286, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2287, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2289, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2290, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2291, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2292, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2293, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2294, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2295, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2296, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2297, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2298, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2299, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2300, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2302, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2303, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2304, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2305, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2306, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2307, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2308, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2309, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2310, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2311, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2312, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2314, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2315, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2316, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2317, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2318, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2319, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2320, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2321, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2322, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2323, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2324, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2325, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2326, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2327, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2328, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2329, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2330, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2331, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2333, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2334, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2335, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2336, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2337, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2338, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2339, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2340, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2341, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2342, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2343, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2344, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2345, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2346, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2347, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2348, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2350, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2351, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2352, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2353, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2354, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2355, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2356, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2357, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2358, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2359, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2360, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2361, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2365, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2369, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2370, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2371, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2372, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2379, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2380, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2381, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2382, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2386, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2387, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2388, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2390, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2395, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2396, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2397, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2398, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2399, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2400, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2401, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2402, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2403, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2404, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2405, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2406, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2408, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2409, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2410, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2411, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2415, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2420, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2421, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2422, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2423, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2424, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2425, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2426, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2427, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2428, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2429, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2430, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2431, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2439, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2440, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2441, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2442, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2443, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2444, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2445, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2446, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2447, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2448, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2449, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2450, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2452, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2453, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2454, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2455, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2456, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2460, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2462, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2463, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2464, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2465, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2466, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2469, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2470, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2471, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2472, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2473, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2474, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2475, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2476, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2477, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2478, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2479, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2480, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2481, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2482, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2483, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2484, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2485, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2486, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2487, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2488, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2489, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2490, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2500, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2502, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2505, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2506, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2508, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2515, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2516, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2517, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2518, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2519, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2520, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2522, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2525, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2526, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2527, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2528, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2529, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2530, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2533, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2534, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2535, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2536, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2537, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2538, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2539, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2540, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2541, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2545, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2546, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2548, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2549, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2550, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2551, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2555, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2556, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2557, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2558, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2559, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2560, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2563, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2564, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2565, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2566, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2567, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2568, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2569, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2570, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2571, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2572, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2573, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2574, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2575, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2576, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2577, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2578, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2579, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2580, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2581, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2582, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2583, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2584, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2585, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2586, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2587, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2588, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2590, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2594, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2600, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2601, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2602, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2603, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2604, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2605, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2606, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2607, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2608, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2609, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2610, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2611, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2612, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2614, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2615, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2616, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2617, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2618, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2619, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2620, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2621, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2622, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2623, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2624, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2625, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2626, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2627, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2628, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2629, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2630, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2631, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2632, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2633, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2640, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2641, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2642, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2643, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2644, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2645, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2646, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2647, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2648, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2649, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2650, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2651, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2652, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2653, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2655, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2656, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2658, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2659, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2660, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2661, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2663, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2665, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2666, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2668, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2669, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2671, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2672, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2675, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2678, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2680, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2681, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2700, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2701, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2702, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2703, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2705, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2706, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2707, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2708, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2710, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2711, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2712, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2713, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2714, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2715, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2716, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2717, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2720, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2721, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2722, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2725, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2726, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2727, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2729, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2730, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2731, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2732, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2733, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2734, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2735, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2736, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2737, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2738, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2739, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2745, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2747, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2748, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2749, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2750, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2751, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2752, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2753, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2754, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2755, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2756, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2757, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2758, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2759, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2760, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2761, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2762, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2763, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2765, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2766, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2767, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2768, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2769, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2770, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2773, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2774, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2775, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2776, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2777, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2778, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2779, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2780, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2782, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2783, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2784, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2785, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2786, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2787, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2790, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2791, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2792, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2793, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2794, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2795, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2796, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2797, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2798, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2799, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2800, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2803, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2804, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2805, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2806, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2807, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2808, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2809, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2810, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2820, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2821, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2823, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2824, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2825, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2827, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2828, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2829, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2830, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2831, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2832, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2833, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2834, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2835, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2836, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2839, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2840, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2842, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2843, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2844, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2845, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2846, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2847, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2848, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2849, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2850, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2852, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2864, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2865, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2866, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2867, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2868, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2869, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2870, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2871, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2873, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2874, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2875, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2876, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2877, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2878, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2879, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2880, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2890, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2891, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2898, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2899, 'Australia/Sydney');
INSERT INTO `sample_postcode_timezone` VALUES(2900, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2901, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2902, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2903, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2904, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2905, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2906, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2911, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2912, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2913, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(2914, 'Australia/ACT');
INSERT INTO `sample_postcode_timezone` VALUES(3000, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3001, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3002, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3003, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3004, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3005, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3006, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3008, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3010, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3011, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3012, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3013, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3015, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3016, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3018, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3019, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3020, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3021, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3022, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3023, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3024, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3025, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3026, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3027, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3028, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3029, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3030, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3031, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3032, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3033, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3034, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3036, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3037, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3038, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3039, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3040, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3041, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3042, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3043, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3044, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3045, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3046, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3047, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3048, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3049, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3050, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3051, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3052, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3053, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3054, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3055, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3056, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3057, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3058, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3059, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3060, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3061, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3062, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3063, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3064, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3065, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3066, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3067, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3068, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3070, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3071, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3072, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3073, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3074, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3075, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3076, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3078, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3079, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3081, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3082, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3083, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3084, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3085, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3086, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3087, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3088, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3089, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3090, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3091, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3093, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3094, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3095, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3096, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3097, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3099, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3101, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3102, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3103, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3104, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3105, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3106, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3107, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3108, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3109, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3110, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3111, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3113, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3114, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3115, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3116, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3121, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3122, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3123, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3124, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3125, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3126, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3127, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3128, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3129, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3130, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3131, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3132, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3133, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3134, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3135, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3136, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3137, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3138, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3139, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3140, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3141, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3142, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3143, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3144, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3145, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3146, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3147, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3148, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3149, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3150, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3151, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3152, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3153, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3154, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3155, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3156, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3158, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3159, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3160, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3161, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3162, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3163, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3164, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3165, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3166, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3167, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3168, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3169, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3170, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3171, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3172, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3173, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3174, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3175, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3176, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3177, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3178, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3179, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3180, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3181, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3182, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3183, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3184, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3185, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3186, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3187, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3188, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3189, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3190, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3191, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3192, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3193, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3194, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3195, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3196, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3197, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3198, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3199, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3200, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3201, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3202, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3204, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3205, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3206, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3207, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3211, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3212, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3214, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3215, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3216, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3217, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3218, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3219, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3220, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3221, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3222, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3223, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3224, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3225, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3226, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3227, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3228, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3230, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3231, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3232, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3233, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3235, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3236, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3237, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3238, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3239, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3240, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3241, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3242, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3243, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3249, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3250, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3251, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3254, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3260, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3264, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3265, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3266, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3267, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3268, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3269, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3270, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3271, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3272, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3273, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3274, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3275, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3276, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3277, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3278, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3279, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3280, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3281, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3282, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3283, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3284, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3285, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3286, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3287, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3289, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3292, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3293, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3294, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3300, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3301, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3302, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3303, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3304, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3305, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3309, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3310, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3311, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3312, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3314, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3315, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3317, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3318, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3319, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3321, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3322, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3323, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3324, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3325, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3328, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3329, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3330, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3331, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3332, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3333, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3334, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3335, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3337, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3338, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3340, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3341, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3342, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3345, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3350, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3351, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3352, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3353, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3354, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3355, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3356, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3357, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3360, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3361, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3363, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3364, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3370, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3371, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3373, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3375, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3377, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3378, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3379, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3380, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3381, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3384, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3385, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3387, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3388, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3390, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3391, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3392, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3393, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3395, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3396, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3400, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3401, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3402, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3407, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3409, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3412, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3413, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3414, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3415, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3418, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3419, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3420, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3423, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3424, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3427, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3428, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3429, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3430, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3431, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3432, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3433, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3434, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3435, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3437, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3438, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3440, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3441, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3442, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3444, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3446, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3447, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3448, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3450, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3451, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3453, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3458, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3460, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3461, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3462, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3463, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3464, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3465, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3467, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3468, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3469, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3472, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3475, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3478, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3480, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3482, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3483, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3485, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3487, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3488, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3489, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3490, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3491, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3494, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3496, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3498, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3500, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3501, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3502, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3505, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3506, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3507, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3509, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3512, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3515, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3516, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3517, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3518, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3520, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3521, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3522, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3523, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3525, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3527, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3529, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3530, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3531, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3533, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3537, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3540, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3542, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3544, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3546, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3549, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3550, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3551, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3552, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3554, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3555, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3556, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3557, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3558, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3559, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3561, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3562, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3563, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3564, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3565, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3566, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3567, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3568, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3570, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3571, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3572, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3573, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3575, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3576, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3579, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3580, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3581, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3583, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3584, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3585, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3586, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3588, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3589, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3590, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3591, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3594, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3595, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3596, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3597, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3599, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3607, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3608, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3610, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3612, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3614, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3616, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3617, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3618, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3619, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3620, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3621, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3622, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3623, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3624, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3629, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3630, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3631, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3632, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3633, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3634, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3635, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3636, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3637, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3638, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3639, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3640, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3641, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3643, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3644, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3646, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3647, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3649, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3658, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3659, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3660, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3661, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3662, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3663, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3664, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3665, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3666, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3669, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3670, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3671, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3672, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3673, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3675, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3676, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3677, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3678, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3682, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3683, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3685, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3687, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3688, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3689, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3690, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3691, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3694, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3695, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3697, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3698, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3699, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3700, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3701, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3704, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3705, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3707, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3708, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3709, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3711, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3712, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3713, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3714, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3715, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3717, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3718, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3719, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3720, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3722, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3723, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3724, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3725, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3726, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3727, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3728, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3730, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3732, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3733, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3735, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3736, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3737, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3738, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3739, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3740, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3741, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3744, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3746, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3747, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3749, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3750, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3751, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3752, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3753, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3754, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3755, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3756, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3757, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3758, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3759, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3760, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3761, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3762, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3763, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3764, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3765, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3766, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3767, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3770, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3775, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3777, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3778, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3779, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3781, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3782, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3783, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3785, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3786, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3787, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3788, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3789, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3791, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3792, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3793, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3795, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3796, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3797, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3799, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3800, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3802, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3803, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3804, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3805, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3806, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3807, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3808, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3809, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3810, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3812, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3813, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3814, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3815, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3816, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3818, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3820, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3821, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3822, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3823, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3824, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3825, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3831, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3832, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3833, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3835, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3840, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3841, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3842, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3844, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3847, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3850, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3851, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3852, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3853, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3854, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3856, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3857, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3858, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3859, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3860, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3862, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3864, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3865, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3869, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3870, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3871, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3873, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3874, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3875, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3878, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3880, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3882, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3885, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3886, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3887, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3888, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3889, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3890, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3891, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3892, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3893, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3895, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3896, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3898, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3900, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3902, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3903, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3904, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3909, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3910, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3911, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3912, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3913, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3915, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3916, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3918, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3919, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3920, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3921, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3922, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3923, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3925, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3926, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3927, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3928, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3929, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3930, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3931, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3933, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3934, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3936, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3937, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3938, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3939, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3940, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3941, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3942, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3943, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3944, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3945, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3946, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3950, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3951, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3953, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3954, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3956, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3957, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3958, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3959, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3960, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3962, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3964, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3965, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3966, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3967, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3971, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3975, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3976, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3977, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3978, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3979, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3980, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3981, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3984, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3987, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3988, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3990, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3991, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3992, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3995, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(3996, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(4000, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4001, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4002, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4003, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4004, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4005, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4006, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4007, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4008, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4009, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4010, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4011, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4012, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4013, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4014, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4017, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4018, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4019, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4020, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4021, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4022, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4025, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4029, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4030, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4031, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4032, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4034, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4035, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4036, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4037, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4051, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4053, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4054, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4055, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4059, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4060, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4061, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4064, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4065, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4066, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4067, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4068, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4069, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4070, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4072, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4073, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4074, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4075, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4076, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4077, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4078, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4101, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4102, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4103, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4104, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4105, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4106, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4107, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4108, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4109, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4110, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4111, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4112, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4113, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4114, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4115, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4116, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4117, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4118, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4119, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4120, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4121, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4122, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4123, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4124, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4125, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4127, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4128, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4129, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4130, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4131, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4132, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4133, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4151, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4152, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4153, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4154, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4155, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4156, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4157, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4158, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4159, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4160, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4161, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4163, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4164, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4165, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4169, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4170, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4171, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4172, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4173, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4174, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4178, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4179, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4183, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4184, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4205, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4207, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4208, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4209, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4210, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4211, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4212, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4213, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4214, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4215, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4216, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4217, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4218, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4219, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4220, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4221, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4222, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4223, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4224, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4225, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4226, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4227, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4228, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4229, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4230, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4270, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4271, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4272, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4275, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4280, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4285, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4287, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4300, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4301, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4303, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4304, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4305, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4306, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4307, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4309, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4310, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4311, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4312, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4313, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4340, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4341, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4342, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4343, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4344, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4345, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4346, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4347, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4350, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4352, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4353, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4354, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4355, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4356, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4357, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4358, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4359, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4360, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4361, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4362, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4363, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4364, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4365, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4370, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4371, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4372, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4373, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4374, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4375, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4376, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4377, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4378, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4380, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4381, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4382, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4383, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4384, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4385, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4387, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4388, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4390, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4400, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4401, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4402, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4403, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4404, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4405, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4406, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4407, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4408, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4410, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4411, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4412, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4413, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4415, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4416, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4417, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4418, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4419, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4420, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4421, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4422, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4423, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4424, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4425, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4426, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4427, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4428, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4454, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4455, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4461, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4462, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4465, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4467, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4468, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4470, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4471, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4472, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4474, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4475, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4477, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4478, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4479, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4480, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4481, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4482, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4486, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4487, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4488, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4489, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4490, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4491, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4492, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4493, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4494, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4496, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4497, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4498, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4500, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4501, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4502, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4503, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4504, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4505, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4506, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4507, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4508, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4509, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4510, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4511, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4512, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4514, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4515, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4516, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4517, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4518, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4519, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4520, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4521, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4550, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4551, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4552, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4553, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4554, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4555, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4556, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4557, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4558, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4559, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4560, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4561, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4562, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4563, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4564, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4565, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4566, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4567, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4568, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4569, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4570, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4571, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4572, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4573, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4574, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4575, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4580, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4581, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4600, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4601, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4605, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4606, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4608, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4610, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4611, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4612, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4613, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4614, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4615, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4620, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4621, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4625, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4626, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4627, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4630, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4650, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4655, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4659, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4660, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4662, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4670, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4671, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4673, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4674, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4676, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4677, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4678, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4680, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4694, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4695, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4697, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4699, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4700, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4701, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4702, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4703, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4704, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4705, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4706, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4707, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4709, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4710, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4711, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4712, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4713, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4714, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4715, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4716, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4717, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4718, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4719, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4720, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4721, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4722, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4723, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4724, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4725, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4726, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4727, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4728, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4730, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4731, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4732, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4733, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4735, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4736, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4737, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4738, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4739, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4740, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4741, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4742, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4743, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4744, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4745, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4746, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4750, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4751, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4753, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4754, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4756, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4757, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4798, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4799, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4800, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4801, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4802, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4803, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4804, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4805, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4806, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4807, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4808, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4809, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4810, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4811, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4812, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4813, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4814, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4815, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4816, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4817, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4818, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4819, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4820, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4821, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4822, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4823, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4824, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4825, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4828, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4829, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4830, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4849, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4850, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4852, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4854, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4855, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4856, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4857, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4858, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4859, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4860, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4861, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4865, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4868, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4869, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4870, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4871, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4872, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4873, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4874, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4875, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4876, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4877, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4878, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4879, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4880, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4881, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4882, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4883, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4884, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4885, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4886, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4887, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4888, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4890, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4891, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(4895, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(5000, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5001, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5005, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5006, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5007, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5008, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5009, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5010, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5011, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5012, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5013, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5014, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5015, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5016, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5017, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5018, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5019, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5020, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5021, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5022, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5023, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5024, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5025, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5031, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5032, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5033, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5034, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5035, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5037, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5038, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5039, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5040, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5041, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5042, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5043, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5044, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5045, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5046, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5047, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5048, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5049, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5050, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5051, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5052, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5061, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5062, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5063, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5064, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5065, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5066, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5067, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5068, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5069, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5070, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5071, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5072, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5073, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5074, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5075, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5076, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5081, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5082, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5083, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5084, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5085, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5086, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5087, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5088, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5089, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5090, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5091, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5092, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5093, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5094, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5095, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5096, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5097, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5098, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5106, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5107, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5108, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5109, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5110, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5111, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5112, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5113, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5114, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5115, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5116, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5117, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5118, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5120, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5121, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5125, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5126, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5127, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5131, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5132, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5133, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5134, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5136, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5137, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5138, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5139, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5140, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5141, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5142, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5144, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5150, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5151, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5152, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5153, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5154, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5155, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5156, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5157, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5158, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5159, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5160, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5161, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5162, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5163, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5164, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5165, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5166, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5167, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5168, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5169, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5170, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5171, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5172, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5173, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5174, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5201, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5202, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5203, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5204, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5210, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5211, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5212, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5213, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5214, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5220, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5221, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5222, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5223, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5231, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5232, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5233, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5234, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5235, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5236, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5237, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5238, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5240, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5241, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5242, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5243, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5244, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5245, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5246, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5250, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5251, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5252, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5253, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5254, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5255, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5256, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5259, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5260, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5261, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5262, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5263, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5264, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5265, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5266, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5267, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5268, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5269, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5270, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5271, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5272, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5273, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5275, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5276, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5277, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5278, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5279, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5280, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5290, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5291, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5301, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5302, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5303, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5304, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5306, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5307, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5308, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5309, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5310, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5311, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5312, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5320, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5321, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5322, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5330, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5331, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5332, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5333, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5340, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5341, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5342, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5343, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5344, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5345, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5346, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5350, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5351, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5352, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5353, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5354, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5355, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5356, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5357, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5360, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5371, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5372, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5373, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5374, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5381, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5400, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5401, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5410, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5411, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5412, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5413, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5414, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5415, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5416, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5417, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5418, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5419, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5420, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5421, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5422, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5431, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5432, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5433, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5434, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5440, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5451, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5452, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5453, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5454, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5455, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5460, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5461, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5462, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5464, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5470, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5471, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5472, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5473, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5480, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5481, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5482, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5483, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5485, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5490, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5491, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5493, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5495, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5501, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5502, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5510, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5520, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5521, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5522, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5523, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5540, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5550, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5552, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5554, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5555, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5556, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5558, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5560, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5570, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5571, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5572, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5573, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5575, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5576, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5577, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5580, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5581, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5582, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5583, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5600, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5601, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5602, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5603, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5604, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5605, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5606, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5607, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5608, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5609, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5630, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5631, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5632, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5633, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5640, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5641, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5642, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5650, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5651, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5652, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5653, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5654, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5655, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5660, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5661, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5670, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5671, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5680, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5690, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5700, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5710, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5720, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5722, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5723, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5724, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5725, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5730, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5731, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5732, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5733, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5734, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5800, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5810, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5839, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5860, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5861, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5862, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5863, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5864, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5865, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5866, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5867, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5868, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5869, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5870, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5871, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5872, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5873, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5874, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5875, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5876, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5877, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5878, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5879, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5880, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5881, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5882, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5883, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5884, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5885, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5886, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5887, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5888, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5889, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5890, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5891, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5892, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5893, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5894, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5895, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5896, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5897, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5898, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5899, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5900, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5901, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5902, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5903, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5904, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5920, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5942, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(5950, 'Australia/Adelaide');
INSERT INTO `sample_postcode_timezone` VALUES(6000, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6001, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6003, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6004, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6005, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6006, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6007, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6008, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6009, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6010, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6011, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6012, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6014, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6015, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6016, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6017, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6018, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6019, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6020, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6021, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6022, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6023, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6024, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6025, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6026, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6027, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6028, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6029, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6030, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6031, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6032, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6033, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6034, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6035, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6036, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6037, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6038, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6041, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6042, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6043, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6044, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6050, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6051, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6052, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6053, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6054, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6055, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6056, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6057, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6058, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6059, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6060, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6061, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6062, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6063, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6064, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6065, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6066, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6067, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6068, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6069, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6070, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6071, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6072, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6073, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6074, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6076, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6081, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6082, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6083, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6084, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6090, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6100, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6101, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6102, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6103, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6104, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6105, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6106, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6107, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6108, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6109, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6110, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6111, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6112, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6121, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6122, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6123, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6124, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6125, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6126, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6147, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6148, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6149, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6150, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6151, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6152, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6153, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6154, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6155, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6156, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6157, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6158, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6159, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6160, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6161, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6162, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6163, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6164, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6165, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6166, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6167, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6168, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6169, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6170, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6171, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6172, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6173, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6174, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6175, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6176, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6180, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6181, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6182, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6207, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6208, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6209, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6210, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6211, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6213, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6214, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6215, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6218, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6220, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6221, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6223, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6224, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6225, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6226, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6227, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6228, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6229, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6230, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6231, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6232, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6233, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6236, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6237, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6239, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6240, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6243, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6244, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6251, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6252, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6253, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6254, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6255, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6256, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6258, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6260, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6262, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6271, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6275, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6280, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6281, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6282, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6284, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6285, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6286, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6288, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6290, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6302, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6304, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6306, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6308, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6309, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6311, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6312, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6313, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6315, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6316, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6317, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6318, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6320, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6321, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6322, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6323, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6324, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6326, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6327, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6328, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6330, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6331, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6332, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6333, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6335, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6336, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6337, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6338, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6341, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6343, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6346, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6348, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6350, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6351, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6352, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6353, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6355, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6356, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6357, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6358, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6359, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6361, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6363, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6365, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6367, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6368, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6369, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6370, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6372, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6373, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6375, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6383, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6384, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6385, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6386, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6390, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6391, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6392, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6393, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6394, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6395, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6396, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6397, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6398, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6401, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6403, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6405, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6407, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6409, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6410, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6411, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6412, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6413, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6414, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6415, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6418, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6419, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6420, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6421, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6422, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6423, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6424, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6425, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6426, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6427, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6428, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6429, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6430, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6431, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6432, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6433, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6434, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6436, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6437, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6438, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6440, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6442, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6443, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6445, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6446, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6447, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6448, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6450, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6452, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6460, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6461, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6462, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6463, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6465, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6466, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6467, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6468, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6470, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6472, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6473, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6475, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6476, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6477, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6479, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6480, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6484, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6485, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6487, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6488, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6489, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6490, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6501, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6502, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6503, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6504, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6505, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6506, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6507, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6509, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6510, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6511, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6512, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6513, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6514, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6515, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6516, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6517, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6518, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6519, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6521, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6522, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6525, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6528, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6530, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6531, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6532, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6535, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6536, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6537, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6556, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6558, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6560, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6562, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6564, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6566, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6567, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6568, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6569, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6571, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6572, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6574, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6575, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6603, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6605, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6606, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6608, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6609, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6612, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6613, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6614, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6616, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6620, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6623, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6625, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6627, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6628, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6630, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6631, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6632, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6635, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6638, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6639, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6640, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6642, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6646, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6701, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6705, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6707, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6710, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6711, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6712, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6713, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6714, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6716, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6718, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6720, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6721, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6722, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6725, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6726, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6728, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6731, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6733, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6740, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6743, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6751, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6753, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6754, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6758, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6760, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6762, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6765, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6770, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6798, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6799, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6800, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6803, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6809, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6817, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6820, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6827, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6830, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6831, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6832, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6837, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6838, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6839, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6840, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6841, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6842, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6843, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6844, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6845, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6846, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6847, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6848, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6849, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6850, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6865, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6872, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6892, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6900, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6901, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6902, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6903, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6904, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6905, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6906, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6907, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6909, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6910, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6911, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6912, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6913, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6914, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6915, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6916, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6917, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6918, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6919, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6920, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6921, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6922, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6923, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6924, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6925, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6926, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6929, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6931, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6932, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6933, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6934, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6935, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6936, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6937, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6938, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6939, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6940, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6941, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6942, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6943, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6944, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6945, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6946, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6947, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6951, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6952, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6953, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6954, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6955, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6956, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6957, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6958, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6959, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6960, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6961, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6963, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6964, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6965, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6966, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6967, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6968, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6969, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6970, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6979, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6980, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6981, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6982, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6983, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6984, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6985, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6986, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6987, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6988, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6989, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6990, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6991, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6992, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(6997, 'Australia/Perth');
INSERT INTO `sample_postcode_timezone` VALUES(7000, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7001, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7002, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7004, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7005, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7006, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7007, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7008, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7009, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7010, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7011, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7012, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7015, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7016, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7017, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7018, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7019, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7020, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7021, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7022, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7023, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7024, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7025, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7026, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7027, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7030, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7050, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7051, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7052, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7053, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7054, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7055, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7109, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7112, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7113, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7116, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7117, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7119, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7120, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7139, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7140, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7150, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7151, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7155, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7162, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7163, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7170, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7171, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7172, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7173, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7174, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7175, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7176, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7177, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7178, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7179, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7180, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7182, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7183, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7184, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7185, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7186, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7187, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7190, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7209, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7210, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7211, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7212, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7213, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7214, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7215, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7216, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7248, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7249, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7250, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7252, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7253, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7254, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7255, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7256, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7257, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7258, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7259, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7260, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7261, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7262, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7263, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7264, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7265, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7267, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7268, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7270, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7275, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7276, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7277, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7290, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7291, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7292, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7300, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7301, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7302, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7303, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7304, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7305, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7306, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7307, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7310, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7315, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7316, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7320, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7321, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7322, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7325, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7330, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7331, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7466, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7467, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7468, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7469, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7470, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7800, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7802, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7803, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7804, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7805, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7806, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7807, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7808, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7809, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7810, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7811, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7812, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7813, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7814, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7823, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7824, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7827, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7828, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7829, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7845, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7850, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7901, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7902, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7903, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7904, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7905, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7906, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7907, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7908, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7909, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7910, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7911, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7912, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7913, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7914, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7915, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7916, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7917, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7918, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7919, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7920, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7921, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7922, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(7923, 'Australia/Tasmania');
INSERT INTO `sample_postcode_timezone` VALUES(8001, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8002, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8003, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8004, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8005, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8006, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8007, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8008, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8009, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8010, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8011, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8045, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8051, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8060, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8061, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8066, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8069, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8070, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8071, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8102, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8103, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8107, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8108, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8111, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8120, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8205, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8383, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8386, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8388, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8390, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8393, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8394, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8396, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8399, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8500, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8507, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8538, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8557, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8576, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8622, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8626, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8627, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8785, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8865, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(8873, 'Australia/Melbourne');
INSERT INTO `sample_postcode_timezone` VALUES(9000, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9001, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9002, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9005, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9007, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9008, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9009, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9010, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9013, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9015, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9016, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9017, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9018, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9019, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9020, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9021, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9022, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9023, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9464, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9726, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9728, 'Australia/Brisbane');
INSERT INTO `sample_postcode_timezone` VALUES(9729, 'Australia/Brisbane');

-- --------------------------------------------------------

--
-- Table structure for table `sample_prefix_timezone`
--

CREATE TABLE `sample_prefix_timezone` (
  `val` int(10) NOT NULL,
  `Time_zone_name` char(64) NOT NULL,
  PRIMARY KEY  (`val`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `sample_prefix_timezone`
--

INSERT INTO `sample_prefix_timezone` VALUES(24, 'Australia/NSW');
INSERT INTO `sample_prefix_timezone` VALUES(26, 'Australia/NSW');
INSERT INTO `sample_prefix_timezone` VALUES(28, 'Australia/NSW');
INSERT INTO `sample_prefix_timezone` VALUES(29, 'Australia/NSW');
INSERT INTO `sample_prefix_timezone` VALUES(35, 'Australia/Victoria');
INSERT INTO `sample_prefix_timezone` VALUES(36, 'Australia/Tasmania');
INSERT INTO `sample_prefix_timezone` VALUES(38, 'Australia/Victoria');
INSERT INTO `sample_prefix_timezone` VALUES(39, 'Australia/Victoria');
INSERT INTO `sample_prefix_timezone` VALUES(73, 'Australia/Queensland');
INSERT INTO `sample_prefix_timezone` VALUES(74, 'Australia/Queensland');
INSERT INTO `sample_prefix_timezone` VALUES(75, 'Australia/Queensland');
INSERT INTO `sample_prefix_timezone` VALUES(86, 'Australia/West');
INSERT INTO `sample_prefix_timezone` VALUES(89, 'Australia/West');
INSERT INTO `sample_prefix_timezone` VALUES(880, 'Australia/Broken_Hill');
INSERT INTO `sample_prefix_timezone` VALUES(881, 'Australia/Adelaide');
INSERT INTO `sample_prefix_timezone` VALUES(882, 'Australia/Adelaide');
INSERT INTO `sample_prefix_timezone` VALUES(883, 'Australia/Adelaide');
INSERT INTO `sample_prefix_timezone` VALUES(884, 'Australia/Adelaide');
INSERT INTO `sample_prefix_timezone` VALUES(885, 'Australia/Adelaide');
INSERT INTO `sample_prefix_timezone` VALUES(886, 'Australia/Adelaide');
INSERT INTO `sample_prefix_timezone` VALUES(887, 'Australia/Adelaide');
INSERT INTO `sample_prefix_timezone` VALUES(888, 'Australia/Adelaide');
INSERT INTO `sample_prefix_timezone` VALUES(889, 'Australia/Darwin');

-- --------------------------------------------------------

--
-- Table structure for table `sample_state_timezone`
--

CREATE TABLE `sample_state_timezone` (
  `val` varchar(64) NOT NULL,
  `Time_zone_name` char(64) NOT NULL,
  PRIMARY KEY  (`val`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `sample_state_timezone`
--

INSERT INTO `sample_state_timezone` VALUES('ACT', 'Australia/ACT');
INSERT INTO `sample_state_timezone` VALUES('Australian Capital Territory', 'Australia/ACT');
INSERT INTO `sample_state_timezone` VALUES('New South Wales', 'Australia/NSW');
INSERT INTO `sample_state_timezone` VALUES('Northern Territory', 'Australia/Darwin');
INSERT INTO `sample_state_timezone` VALUES('NSW', 'Australia/NSW');
INSERT INTO `sample_state_timezone` VALUES('NT', 'Australia/Darwin');
INSERT INTO `sample_state_timezone` VALUES('QLD', 'Australia/Queensland');
INSERT INTO `sample_state_timezone` VALUES('Queensland', 'Australia/Queensland');
INSERT INTO `sample_state_timezone` VALUES('SA', 'Australia/Adelaide');
INSERT INTO `sample_state_timezone` VALUES('South Australia', 'Australia/Adelaide');
INSERT INTO `sample_state_timezone` VALUES('TAS', 'Australia/Tasmania');
INSERT INTO `sample_state_timezone` VALUES('Tasmania', 'Australia/Tasmania');
INSERT INTO `sample_state_timezone` VALUES('VIC', 'Australia/Victoria');
INSERT INTO `sample_state_timezone` VALUES('Victoria', 'Australia/Victoria');
INSERT INTO `sample_state_timezone` VALUES('WA', 'Australia/Perth');
INSERT INTO `sample_state_timezone` VALUES('Western Australia', 'Australia/Perth');

-- --------------------------------------------------------

--
-- Table structure for table `sample_var`
--

CREATE TABLE `sample_var` (
  `sample_id` bigint(20) NOT NULL,
  `var` char(128) NOT NULL,
  `val` varchar(256) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY  (`sample_id`,`var`),
  KEY `sample_id` (`sample_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `sample_var`
--

-- --------------------------------------------------------

--
-- Table structure for table `sample_var_type`
--

CREATE TABLE `sample_var_type` (
  `type` int(11) NOT NULL auto_increment,
  `description` varchar(255) NOT NULL,
  `table` varchar(255) NOT NULL,
  PRIMARY KEY  (`type`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `sample_var_type`
--

INSERT INTO `sample_var_type` VALUES(1, 'String', '');
INSERT INTO `sample_var_type` VALUES(2, 'Phone number', 'sample_prefix_timezone');
INSERT INTO `sample_var_type` VALUES(3, 'Primary phone number', 'sample_prefix_timezone');
INSERT INTO `sample_var_type` VALUES(4, 'State', 'sample_state_timezone');
INSERT INTO `sample_var_type` VALUES(5, 'Postcode', 'sample_postcode_timezone');
INSERT INTO `sample_var_type` VALUES(6, 'Respondent first name', '');
INSERT INTO `sample_var_type` VALUES(7, 'Respondent last name', '');

-- --------------------------------------------------------

--
-- Table structure for table `sessions2`
--

CREATE TABLE `sessions2` (
  `sesskey` varchar(64) NOT NULL default '',
  `expiry` datetime NOT NULL,
  `expireref` varchar(250) default '',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `sessdata` longtext,
  PRIMARY KEY  (`sesskey`),
  KEY `sess2_expiry` (`expiry`),
  KEY `sess2_expireref` (`expireref`)
) ENGINE=MyISAM DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `sessions2`
--


-- --------------------------------------------------------

--
-- Table structure for table `shift`
--

CREATE TABLE `shift` (
  `shift_id` bigint(20) NOT NULL auto_increment,
  `questionnaire_id` bigint(20) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY  (`shift_id`),
  KEY `questionnaire_id` (`questionnaire_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `shift`
--


-- --------------------------------------------------------

--
-- Table structure for table `shift_report`
--

CREATE TABLE `shift_report` (
  `shift_report_id` bigint(20) NOT NULL auto_increment,
  `shift_id` bigint(20) NOT NULL,
  `operator_id` bigint(20) NOT NULL,
  `report` text NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY  (`shift_report_id`),
  KEY `shift_id` (`shift_id`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `shift_report`
--


-- --------------------------------------------------------

--
-- Table structure for table `shift_template`
--

CREATE TABLE `shift_template` (
  `day_of_week` tinyint(1) NOT NULL,
  `start` time NOT NULL,
  `end` time NOT NULL,
  KEY `day_of_week` (`day_of_week`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `shift_template`
--

INSERT INTO `shift_template` VALUES(2, '17:00:00', '20:30:00');
INSERT INTO `shift_template` VALUES(3, '17:00:00', '20:30:00');
INSERT INTO `shift_template` VALUES(4, '17:00:00', '20:30:00');
INSERT INTO `shift_template` VALUES(5, '17:00:00', '20:30:00');
INSERT INTO `shift_template` VALUES(6, '17:00:00', '20:30:00');
INSERT INTO `shift_template` VALUES(7, '09:00:00', '13:00:00');
INSERT INTO `shift_template` VALUES(7, '13:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `timezone_template`
--

CREATE TABLE `timezone_template` (
  `Time_zone_name` char(64) NOT NULL,
  PRIMARY KEY  (`Time_zone_name`)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

--
-- Dumping data for table `timezone_template`
--

INSERT INTO `timezone_template` VALUES('Australia/ACT');
INSERT INTO `timezone_template` VALUES('Australia/Adelaide');
INSERT INTO `timezone_template` VALUES('Australia/Darwin');
INSERT INTO `timezone_template` VALUES('Australia/NSW');
INSERT INTO `timezone_template` VALUES('Australia/Perth');
INSERT INTO `timezone_template` VALUES('Australia/Queensland');
INSERT INTO `timezone_template` VALUES('Australia/Tasmania');
INSERT INTO `timezone_template` VALUES('Australia/Victoria');
