CALL spLogout('1', 'CD86F1B6C54981259EC9');

TRUNCATE users;

SELECT * FROM MyDatesDB.users;

SELECT * FROM MyDatesDB.groups;

CALL spLogout('1', 'F9F1A985F4A06EA36974');

CALL spRegister('kamalas', 'abcde12345', 'firstname', 'lastname');

