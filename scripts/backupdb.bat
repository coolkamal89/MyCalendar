@title Backing up database script
@echo off

mysqldump.exe --user=root --max_allowed_packet=1G --host=127.0.0.1 --port=3306 --default-character-set=utf8 --single-transaction=TRUE --routines --events "MyDatesDB" > script.sql

echo "Database backup done"

@pause