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
'tel_index'TEXT NOT NULL,
'tel_creation'INTEGER NOT NULL,
'tel_modification'INTEGER NOT NULL
);

CREATE TABLE url_info(
'contacts_id'TEXT NOT NULL,
'url_content'TEXT NOT NULL,
'url_label'TEXT NOT NULL,
'url_index'TEXT NOT NULL,
'url_creation'INTEGER NOT NULL,
'url_modification'INTEGER NOT NULL
);

CREATE TABLE email_info(
'contacts_id'TEXT NOT NULL,
'email_content'TEXT NOT NULL,
'email_label'TEXT NOT NULL,
'email_index'TEXT NOT NULL,
'email_creation'INTEGER NOT NULL,
'email_modification'INTEGER NOT NULL
);

CREATE TABLE address_info(
'contacts_id'TEXT NOT NULL,
'address_street'TEXT,
'address_zip'TEXT,
'address_city'TEXT,
'address_state'TEXT,
'address_country'TEXT,
'address_label'TEXT NOT NULL,
'address_index'TEXT NOT NULL,
'address_creation'INTEGER NOT NULL,
'address_modification'INTEGER NOT NULL
);

CREATE TABLE instantMessage_info(
'contacts_id'TEXT NOT NULL,
'instantMessage_username'TEXT NOT NULL,
'instantMessage_service'TEXT,
'instantMessage_label'TEXT NOT NULL,
'instantMessage_index'TEXT NOT NULL,
'instantMessage_type'TEXT NOT NULL,
'instantMessage_creation'INTEGER NOT NULL,
'instantMessage_modification'INTEGER NOT NULL
);

CREATE TABLE date_info(
'contacts_id'TEXT NOT NULL,
'date_time'INTEGER NOT NULL,
'date_label'TEXT NOT NULL,
'date_remind'TEXT,
'date_index'TEXT NOT NULL,
'date_type'TEXT NOT NULL,
'date_creation'INTEGER NOT NULL,
'date_modification'INTEGER NOT NULL
);

CREATE TABLE account_info(
'contacts_id'TEXT NOT NULL,
'account_content'TEXT NOT NULL,
'account_label'TEXT NOT NULL,
'account_index'TEXT NOT NULL,
'account_creation'INTEGER NOT NULL,
'account_modification'INTEGER NOT NULL
);

CREATE TABLE relate_info(
'contacts_id'TEXT NOT NULL,
'relate_id'TEXT NOT NULL,
'relate_label'TEXT NOT NULL,
'relate_index'TEXT NOT NULL,
'relate_creation'INTEGER NOT NULL,
'relate_modification'INTEGER NOT NULL
);

CREATE TABLE certificate_info(
'contacts_id'TEXT NOT NULL,
'certificate_content'TEXT NOT NULL,
'certificate_label'TEXT NOT NULL,
'certificate_index'TEXT NOT NULL,
'certificate_creation'INTEGER NOT NULL,
'certificate_modification'INTEGER NOT NULL
);

CREATE TABLE tag_info(
'tag_name'TEXT PRIMARY KEY,
'tag_type'TEXT NOT NULL,
'tag_creation'INTEGER NOT NULL,
'tag_modification'INTEGER NOT NULL
);

CREATE TABLE servicer_rule(
'servicer_rule_label'TEXT NOT NULL,
'servicer_rule_content'TEXT NOT NULL
);

CREATE TABLE user_info(
'user_info_phone'TEXT NOT NULL,
'user_info_username'TEXT NOT NULL,
'user_info_password'TEXT NOT NULL
);

CREATE TABLE memo_info(
'memo_id'TEXT PRIMARY KEY,
'memo_subject'TEXT,
'memo_des'TEXT,
'memo_date'TEXT,
'memo_remind'INTEGER,
'memo_creation'INTEGER NOT NULL,
'memo_modification'INTEGER NOT NULL
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

REPLACE INTO config VALUES(1001, 0, DATETIME('now'));
INSERT INTO servicer_rule VALUES("中国移动","134*");
INSERT INTO servicer_rule VALUES("中国移动","135*");
INSERT INTO servicer_rule VALUES("中国移动","136*");
INSERT INTO servicer_rule VALUES("中国移动","137*");
INSERT INTO servicer_rule VALUES("中国移动","138*");
INSERT INTO servicer_rule VALUES("中国移动","139*");
INSERT INTO servicer_rule VALUES("中国移动","150*");
INSERT INTO servicer_rule VALUES("中国移动","151*");
INSERT INTO servicer_rule VALUES("中国移动","152*");
INSERT INTO servicer_rule VALUES("中国移动","157*");
INSERT INTO servicer_rule VALUES("中国移动","158*");
INSERT INTO servicer_rule VALUES("中国移动","159*");
INSERT INTO servicer_rule VALUES("中国移动","187*");
INSERT INTO servicer_rule VALUES("中国移动","188*");
INSERT INTO servicer_rule VALUES("中国联通","130*");
INSERT INTO servicer_rule VALUES("中国联通","131*");
INSERT INTO servicer_rule VALUES("中国联通","132*");
INSERT INTO servicer_rule VALUES("中国联通","155*");
INSERT INTO servicer_rule VALUES("中国联通","156*");
INSERT INTO servicer_rule VALUES("中国联通","185*");
INSERT INTO servicer_rule VALUES("中国联通","186*");
INSERT INTO servicer_rule VALUES("中国电信","133*");
INSERT INTO servicer_rule VALUES("中国电信","153*");
INSERT INTO servicer_rule VALUES("中国电信","180*");
INSERT INTO servicer_rule VALUES("中国电信","189*");