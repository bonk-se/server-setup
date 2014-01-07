/**
 * Database schema for ProFTP-DB
 *
 * @author miken@bonk.se
 */

USE ftpusers;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
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
INSERT INTO users SET userid = "foo", passwd = PASSWORD('bar'), uid = 1000, gid = 1001;

DROP TABLE IF EXISTS groups;
CREATE TABLE groups (
  groupname varchar(16) NOT NULL default '',
  gid smallint(6) NOT NULL default '1001',
  members varchar(16) NOT NULL default '',
  KEY groupname (groupname)
) TYPE=MyISAM COMMENT='ProFTP group table';

/**
 * This group should be created in the system as well
 */
INSERT INTO groups SET groupname = 'ftpusers', 1001, 'ftpusers';
