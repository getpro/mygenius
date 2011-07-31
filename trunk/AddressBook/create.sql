sqlite3 AddressBook.db

CREATE TABLE images (
    'contacts_id'            TEXT PRIMARY KEY,
    'image'                  BLOB,
    'updated_at'             DATETIME
);

CREATE TABLE contacts_info(
'contacts_id'TEXT PRIMARY KEY,
'contacts_name'TEXT,
'contacts_sex'INTEGER,
'contacts_relation_id'TEXT,
'contacts_relation_name'TEXT,
'contacts_phone'TEXT,
'contacts_work_address'TEXT,
'contacts_home_address'TEXT,
'contacts_email'TEXT,
'contacts_recommend_id'TEXT,
'contacts_recommend_name'TEXT
);

CREATE TABLE relation (
    'relation_id'             TEXT PRIMARY KEY,
    'relation_name'           TEXT	 
);

CREATE TABLE config (
    'config_copy_addressbook'   INTEGER,
    'config_first_use'          DATETIME	 
);