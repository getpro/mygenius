sqlite3 AddressBook.db

CREATE TABLE contacts_info(
'contacts_id'TEXT PRIMARY KEY,
'contacts_lastname'TEXT,
'contacts_firstname'TEXT,
'contacts_prefix'TEXT,
'contacts_firstnamephonetic'TEXT,
'contacts_lastnamephonetic'TEXT,
'contacts_middlename'TEXT,
'contacts_suffix'TEXT,
'contacts_nickname'TEXT,
'contacts_organization'TEXT,
'contacts_jobtitle'TEXT,
'contacts_department'TEXT,
'contacts_headImage'BLOB,
'contacts_sex'TEXT,
'contacts_ring'TEXT,
'contacts_recommend_id'TEXT,
'contacts_group_id'TEXT,
'contacts_birthday'INTEGER,
'contacts_note'TEXT,
'contacts_constellation'TEXT,
'contacts_blood'TEXT,
'contacts_add_type'TEXT,
'contacts_creation'INTEGER NOT NULL,
'contacts_modification'INTEGER NOT NULL
);

CREATE TABLE group_info(
'group_id'TEXT PRIMARY KEY,
'group_name'TEXT NOT NULL,
'group_creation'INTEGER NOT NULL,
'group_modification'INTEGER NOT NULL
);

CREATE TABLE tel_info(
'contacts_id'TEXT NOT NULL,
'tel_num'TEXT NOT NULL,
'tel_label'TEXT NOT NULL,
'tel_servicer'TEXT,
'tel_index'TEXT NOT NULL
);

CREATE TABLE url_info(
'contacts_id'TEXT NOT NULL,
'url_content'TEXT NOT NULL,
'url_label'TEXT NOT NULL,
'url_index'TEXT NOT NULL
);

CREATE TABLE email_info(
'contacts_id'TEXT NOT NULL,
'email_content'TEXT NOT NULL,
'email_label'TEXT NOT NULL,
'email_index'TEXT NOT NULL
);

CREATE TABLE address_info(
'contacts_id'TEXT NOT NULL,
'address_street'TEXT,
'address_zip'TEXT,
'address_city'TEXT,
'address_state'TEXT,
'address_country'TEXT,
'address_label'TEXT NOT NULL,
'address_index'TEXT NOT NULL
);

CREATE TABLE instantMessage_info(
'contacts_id'TEXT NOT NULL,
'instantMessage_username'TEXT NOT NULL,
'instantMessage_service'TEXT NOT NULL,
'instantMessage_label'TEXT NOT NULL,
'instantMessage_index'TEXT NOT NULL
);

CREATE TABLE date_info(
'contacts_id'TEXT NOT NULL,
'date_time'INTEGER NOT NULL,
'date_label'TEXT NOT NULL,
'date_remind'TEXT,
'date_index'TEXT NOT NULL
);

CREATE TABLE account_info(
'contacts_id'TEXT NOT NULL,
'account_content'TEXT NOT NULL,
'account_label'TEXT NOT NULL,
'account_index'TEXT NOT NULL
);

CREATE TABLE certificate_info(
'contacts_id'TEXT NOT NULL,
'certificate_content'TEXT NOT NULL,
'certificate_label'TEXT NOT NULL,
'certificate_index'TEXT NOT NULL
);

CREATE TABLE tag_info(
'tag_id'TEXT PRIMARY KEY,
'tag_name'TEXT NOT NULL,
'tag_type'TEXT NOT NULL,
'tag_creation'INTEGER NOT NULL,
'tag_modification'INTEGER NOT NULL
);

CREATE TABLE memo_info(
'memo_id'TEXT PRIMARY KEY,
'memo_subject'TEXT,
'memo_des'TEXT,
'memo_date'TEXT,
'memo_remind'INTEGER
);

CREATE TABLE date_type(
'date_type_id'TEXT PRIMARY KEY,
'date_type_name'TEXT
);

CREATE TABLE config(
'config_id'TEXT PRIMARY KEY,
'config_copy_addressbook'INTEGER,
'config_first_use'DATETIME
);

REPLACE INTO config VALUES(1001, 0, DATETIME('now'))