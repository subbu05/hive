SELECT 'Upgrading MetaStore schema from 3.1.0 to 3.2.0' AS ' ';

-- HIVE-19267
CREATE TABLE TXN_WRITE_NOTIFICATION_LOG (
  WNL_ID bigint NOT NULL,
  WNL_TXNID bigint NOT NULL,
  WNL_WRITEID bigint NOT NULL,
  WNL_DATABASE varchar(128) NOT NULL,
  WNL_TABLE varchar(128) NOT NULL,
  WNL_PARTITION varchar(767) NOT NULL,
  WNL_TABLE_OBJ longtext NOT NULL,
  WNL_PARTITION_OBJ longtext,
  WNL_FILES longtext,
  WNL_EVENT_TIME INT(11) NOT NULL,
  PRIMARY KEY (WNL_TXNID, WNL_DATABASE, WNL_TABLE, WNL_PARTITION)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `SEQUENCE_TABLE` (`SEQUENCE_NAME`, `NEXT_VAL`) VALUES ('org.apache.hadoop.hive.metastore.model.MTxnWriteNotificationLog', 1);

-- HIVE-20221
ALTER TABLE PARTITION_PARAMS MODIFY PARAM_VALUE MEDIUMTEXT;

-- HIVE-21077
ALTER TABLE `DBS` ADD `CREATE_TIME` INT(11);
ALTER TABLE `CTLGS` ADD `CREATE_TIME` INT(11);

-- These lines need to be last.  Insert any changes above.
UPDATE VERSION SET SCHEMA_VERSION='3.2.0', VERSION_COMMENT='Hive release version 3.2.0' where VER_ID=1;
SELECT 'Finished upgrading MetaStore schema from 3.1.0 to 3.2.0' AS ' ';

