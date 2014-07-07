/**
 * Database schema for ProFTP-DB
 *
 * @author miken@bonk.se
 */


CREATE DATABASE IF NOT EXISTS proftpd DEFAULT CHARACTER SET utf8;

USE mysql;

INSERT IGNORE INTO db VALUES
('localhost','proftpd','proftpd_user','Y','Y','Y','Y','Y','Y','N','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','N','N');

INSERT IGNORE INTO user VALUES
('localhost','proftpd_user','*EAB00B73E20B960DD569E91D9E5C2BE9264BCB2C','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'',NULL);

FLUSH PRIVILEGES;

USE proftpd;

CREATE TABLE IF NOT EXISTS users (
  id int(10) unsigned NOT NULL auto_increment,
  userid varchar(32) NOT NULL default '',
  passwd varchar(50) NOT NULL default '',
  uid smallint(6) NOT NULL default '5500',
  gid smallint(6) NOT NULL default '1001',
  homedir varchar(255) NOT NULL default '/ztorage',
  shell varchar(32) NOT NULL default '/usr/sbin/nologin',
  count int(11) NOT NULL default 0,
  accessed timestamp NOT NULL,
  modified datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  UNIQUE KEY userid (userid)
) ENGINE=MyISAM COMMENT='ProFTP user table';

/**
 * Example query for adding users
 *
 * uid and gid should match real users if you want proper file owners.
 */
#INSERT INTO users SET userid = "foo", passwd = PASSWORD('bar'), uid = 1000, gid = 1001;

CREATE TABLE IF NOT EXISTS  groups (
  groupname varchar(16) NOT NULL default '',
  gid smallint(6) NOT NULL default '1001',
  members varchar(16) NOT NULL default '',
  KEY groupname (groupname)
) ENGINE=MyISAM COMMENT='ProFTP group table';

/**
 * This group should be created in the system as well
 * groupadd -g 1001 ftpusers
 * useradd -g ftpusers -u 5500 -M -r -s /bin/false ftpuser
 */
INSERT IGNORE INTO groups SET groupname = 'ftpusers', gid = 1001, members = 'ftpusers';
