SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


-- --------------------------------------------------------

--
-- Table structure for table `authassignment`
--

CREATE TABLE IF NOT EXISTS `AuthAssignment` (
  `itemname` varchar(64) collate utf8_unicode_ci NOT NULL,
  `userid` varchar(64) collate utf8_unicode_ci NOT NULL,
  `bizrule` text collate utf8_unicode_ci,
  `data` text collate utf8_unicode_ci,
  PRIMARY KEY  (`itemname`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `authassignment`
--


-- --------------------------------------------------------

--
-- Table structure for table `authitem`
--

CREATE TABLE IF NOT EXISTS `AuthItem` (
  `name` varchar(64) collate utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text collate utf8_unicode_ci,
  `bizrule` text collate utf8_unicode_ci,
  `data` text collate utf8_unicode_ci,
  PRIMARY KEY  (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `authitem`
--

INSERT INTO `AuthItem` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('Authenticated', 2, NULL, NULL, 'N;'),
('Guest', 2, NULL, NULL, 'N;');

-- --------------------------------------------------------

--
-- Table structure for table `authitemchild`
--

CREATE TABLE IF NOT EXISTS `authitemchild` (
  `parent` varchar(64) collate utf8_unicode_ci NOT NULL,
  `child` varchar(64) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `authitemchild`
--
--

-- --------------------------------------------------------

--
-- Table structure for table `file_info`
--

CREATE TABLE IF NOT EXISTS `file_info` (
  `id` int(10) NOT NULL auto_increment,
  `org_file_path` varchar(2084) collate utf8_bin default NULL,
  `temp_file_path` varchar(1000) collate utf8_bin default NULL COMMENT 'orginial file path.  2083 character URL appears to be IE limit',
  `file_type_id` int(1) NOT NULL default '0' COMMENT 'current file path on the server',
  `checksum_created` int(1) NOT NULL default '0',
  `checksum` varchar(40) collate utf8_bin default NULL COMMENT 'file check sum sha1 or md5. sha1 is the default',
  `virus_check` int(1) NOT NULL default '0' COMMENT 'has file had virus check',
  `dynamic_file` int(1) NOT NULL default '0' COMMENT 'is the file dynamically generated from orginal URL',
  `last_modified` varchar(15) collate utf8_bin default NULL COMMENT 'file last modified timestamp',
  `problem_file` int(1) NOT NULL default '0',
  `user_id` int(6) NOT NULL default '0' COMMENT "CONSTRAINT FOREIGN KEY (user_id) REFERENCES user(id)",
  `upload_file_id` int(6) NOT NULL default '0' COMMENT "CONSTRAINT FOREIGN KEY (upload_file_id) REFERENCES user_uploads(id)",
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='downloaded file information' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `file_info`
--

-- --------------------------------------------------------

--
-- Table structure for table `files_for_download`
--

CREATE TABLE IF NOT EXISTS `files_for_download` (
  `id` int(10) NOT NULL auto_increment,
  `url` varchar(500) collate utf8_unicode_ci NOT NULL,
  `user_uploads_id` int(7) NOT NULL COMMENT "CONSTRAINT FOREIGN KEY (user_uploads_id) REFERENCES user_uploads(id)",
  `user_id` int(6) NOT NULL COMMENT "CONSTRAINT FOREIGN KEY (user_id) REFERENCES user(id)",
  `processed` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `files_for_download`
--


-- --------------------------------------------------------

--
-- Table structure for table `rights`
--

CREATE TABLE IF NOT EXISTS `Rights` (
  `itemname` varchar(64) collate utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY  (`itemname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `rights`
--


-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(5) NOT NULL auto_increment,
  `username` varchar(25) collate utf8_unicode_ci NOT NULL,
  `email` varchar(256) collate utf8_unicode_ci NOT NULL,
  `password` varchar(64) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user`
--


-- --------------------------------------------------------

--
-- Table structure for table `user_session_info`
--

CREATE TABLE IF NOT EXISTS `user_session_info` (
  `id` char(32) collate utf8_unicode_ci NOT NULL,
  `expire` int(11) default NULL,
  `data` text collate utf8_unicode_ci,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_session_info`
--

-- --------------------------------------------------------

--
-- Table structure for table `user_uploads`
--

CREATE TABLE IF NOT EXISTS `upload` (
  `id` int(7) NOT NULL auto_increment,
  `user_id` int(6) NOT NULL COMMENT "CONSTRAINT FOREIGN KEY (user_id) REFERENCES user(id)",
  `upload_path` varchar(250) collate utf8_unicode_ci NOT NULL,
  `processed` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `upload`
--



--
-- Constraints for dumped tables
--

--
-- Constraints for table `authassignment`
--
ALTER TABLE `AuthAssignment`
  ADD CONSTRAINT `AuthAssignment_ibfk_1` FOREIGN KEY (`itemname`) REFERENCES `AuthItem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `authitemchild`
--
ALTER TABLE `authitemchild`
  ADD CONSTRAINT `authitemchild_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `AuthItem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `authitemchild_ibfk_2` FOREIGN KEY (`child`) REFERENCES `AuthItem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rights`
--
ALTER TABLE `Rights`
  ADD CONSTRAINT `Rights_ibfk_1` FOREIGN KEY (`itemname`) REFERENCES `AuthItem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;
