sqlite3 AddressBook.db

CREATE TABLE images (
    'contacts_id'            TEXT PRIMARY KEY,
    'image'                  BLOB,
    'updated_at'             DATETIME
);

CREATE TABLE contacts_info(
'contacts_id'TEXT PRIMARY KEY,
'contacts_name'TEXT,
'contacts_organization'TEXT,
'contacts_sex'INTEGER,
'contacts_homeemail'TEXT,
'contacts_workemail'TEXT,
'contacts_home_address'TEXT,
'contacts_work_address'TEXT,
'contacts_mobilephone'TEXT,
'contacts_iphone'TEXT,
'contacts_recommend_id'TEXT,
'contacts_recommend_name'TEXT,
'contacts_relation_id'TEXT,
'contacts_relation_name'TEXT
);

CREATE TABLE relation (
    'relation_id'             TEXT PRIMARY KEY,
    'relation_name'           TEXT	 
);

CREATE TABLE config (
    'config_id'                 TEXT PRIMARY KEY,
    'config_copy_addressbook'   INTEGER,
    'config_first_use'          DATETIME	 
);

CREATE TABLE memo_info(
'memo_id'TEXT PRIMARY KEY,
'memo_subject'TEXT,
'memo_des'TEXT,
'memo_date'TEXT,
'memo_remind'INTEGER
);

CREATE TABLE date_info(
'date_id'TEXT PRIMARY KEY,
'date_type_id'TEXT,
'date_type_name'TEXT,
'date_des'TEXT,
'date_date'TEXT,
'date_remind'INTEGER
);

CREATE TABLE date_type(
'date_type_id'TEXT PRIMARY KEY,
'date_type_name'TEXT	 
);


REPLACE INTO config VALUES(1001, 0, DATETIME('now'))