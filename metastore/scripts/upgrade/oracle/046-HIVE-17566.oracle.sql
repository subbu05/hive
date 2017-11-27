CREATE TABLE WM_RESOURCEPLAN
(
    RP_ID bigint NOT NULL,
    "NAME" nvarchar(128) NOT NULL,
    QUERY_PARALLELISM int,
    STATUS nvarchar(20) NOT NULL,
    DEFAULT_POOL_ID bigint
);

ALTER TABLE WM_RESOURCEPLAN ADD CONSTRAINT WM_RESOURCEPLAN_PK PRIMARY KEY (RP_ID);

CREATE UNIQUE INDEX UNIQUE_WM_RESOURCEPLAN ON WM_RESOURCEPLAN ("NAME");


CREATE TABLE WM_POOL
(
    POOL_ID bigint NOT NULL,
    RP_ID bigint NOT NULL,
    PATH nvarchar(1024) NOT NULL,
    ALLOC_FRACTION DOUBLE,
    QUERY_PARALLELISM int,
    SCHEDULING_POLICY nvarchar(1024)
);

ALTER TABLE WM_POOL ADD CONSTRAINT WM_POOL_PK PRIMARY KEY (POOL_ID);

CREATE UNIQUE INDEX UNIQUE_WM_POOL ON WM_POOL (RP_ID, "NAME");
ALTER TABLE WM_POOL ADD CONSTRAINT WM_POOL_FK1 FOREIGN KEY (RP_ID) REFERENCES WM_RESOURCEPLAN (RP_ID);

ALTER TABLE WM_RESOURCEPLAN ADD CONSTRAINT WM_RESOURCEPLAN_FK1 FOREIGN KEY (DEFAULT_POOL_ID) REFERENCES WM_POOL (POOL_ID);

CREATE TABLE WM_TRIGGER
(
    TRIGGER_ID bigint NOT NULL,
    RP_ID bigint NOT NULL,
    "NAME" nvarchar(128) NOT NULL,
    TRIGGER_EXPRESSION nvarchar(1024),
    ACTION_EXPRESSION nvarchar(1024)
);

ALTER TABLE WM_TRIGGER ADD CONSTRAINT WM_TRIGGER_PK PRIMARY KEY (TRIGGER_ID);

CREATE UNIQUE INDEX UNIQUE_WM_TRIGGER ON WM_TRIGGER (RP_ID, "NAME");

ALTER TABLE WM_TRIGGER ADD CONSTRAINT WM_TRIGGER_FK1 FOREIGN KEY (RP_ID) REFERENCES WM_RESOURCEPLAN (RP_ID);


CREATE TABLE WM_POOL_TO_TRIGGER
(
    POOL_ID bigint NOT NULL,
    TRIGGER_ID bigint NOT NULL
);

ALTER TABLE WM_POOL_TO_TRIGGER ADD CONSTRAINT WM_POOL_TO_TRIGGER_PK PRIMARY KEY (POOL_ID, TRIGGER_ID);

ALTER TABLE WM_POOL_TO_TRIGGER ADD CONSTRAINT WM_POOL_TO_TRIGGER_FK1 FOREIGN KEY (POOL_ID) REFERENCES WM_POOL (POOL_ID);

ALTER TABLE WM_POOL_TO_TRIGGER ADD CONSTRAINT WM_POOL_TO_TRIGGER_FK2 FOREIGN KEY (TRIGGER_ID) REFERENCES WM_TRIGGER (TRIGGER_ID);


CREATE TABLE WM_MAPPING
(
    MAPPING_ID bigint NOT NULL,
    RP_ID bigint NOT NULL,
    ENTITY_TYPE nvarchar(10) NOT NULL,
    ENTITY_NAME nvarchar(128) NOT NULL,
    POOL_ID bigint,
    ORDERING int
);

ALTER TABLE WM_MAPPING ADD CONSTRAINT WM_MAPPING_PK PRIMARY KEY (MAPPING_ID);

CREATE UNIQUE INDEX UNIQUE_WM_MAPPING ON WM_MAPPING (RP_ID, ENTITY_TYPE, ENTITY_NAME);

ALTER TABLE WM_MAPPING ADD CONSTRAINT WM_MAPPING_FK1 FOREIGN KEY (RP_ID) REFERENCES WM_RESOURCEPLAN (RP_ID);

ALTER TABLE WM_MAPPING ADD CONSTRAINT WM_MAPPING_FK2 FOREIGN KEY (POOL_ID) REFERENCES WM_POOL (POOL_ID);
