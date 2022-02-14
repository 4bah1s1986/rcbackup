#!/bin/bash
# Disediakan oleh Abdul Wahid bin Ani
# Skrip backup untuk web yang diuruskan menggunakan RUNCLOUD

BASEDIR=$(dirname "$0")
source $BASEDIR/config

find $BACKUP_DIR/ -iname "$BACKUP_PREFIX*.tgz" -mtime +$SAVE_BACKUP_DURATION -exec rm -rf {} \;
find $BACKUP_DIR/ -iname "$BACKUP_PREFIX*.sql" -mtime +$SAVE_BACKUP_DURATION -exec rm -rf {} \;

cd $BASEDIR/setbackup;
BACKUPCONF_PATH=${PWD};

for i in $(ls -1 *.conf);do
	SYSTEM_USER=$(head -n 1 $i);
	WEB_FOLDER=$(head -n 2 $i|tail -n 1);
	LOCAL_DB=$(head -n 3 $i|tail -n 1);
	DB_NAME=$(head -n 4 $i|tail -n 1);	
	DB_HOST=$(head -n 5 $i|tail -n 1);
	DB_USER=$(head -n 6 $i|tail -n 1);
	DB_PASS=$(head -n 7 $i|tail -n 1);
	
	mkdir -p $BACKUP_DIR/$WEB_FOLDER;
	OUTPUT=${BACKUP_PREFIX}${WEB_FOLDER}${BACKUP_SUFFIX};
	
	if [ $LOCAL_DB = 1 ];then
		mysqldump $DB_NAME > $BACKUP_DIR/$WEB_FOLDER/$OUTPUT.sql
	else
		mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/$WEB_FOLDER/$OUTPUT.sql
	fi
	
	cd /home/$SYSTEM_USER/webapps;
	tar zcvf $BACKUP_DIR/$WEB_FOLDER/$OUTPUT.tgz $WEB_FOLDER/
	
	cd $BACKUPCONF_PATH;
done
