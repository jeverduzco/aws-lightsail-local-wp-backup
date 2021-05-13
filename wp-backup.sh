#!/usr/bin/env bash
# This script only backup the wp-content folder and database
set -e

backup_time=$(date +"%Y-%m-%d-%H%M%S")

echo "Initializing the backup copy"

fixPremissions() {
    chown bitnami:bitnami -R /var/backups/wordpress
    echo "Backup complete!"
}

backupDataBase() {
    mysql_password=`cat /home/bitnami/bitnami_application_password`
    mysqldump -h"localhost" -u"root" -p"${mysql_password}" --quick --opt --single-transaction bitnami_wordpress > /var/backups/wordpress/database-backup-${backup_time}.sql
    fixPremissions
}

backupContent() {
    WORDPRESS="/opt/bitnami/apps/wordpress/htdocs/wp-content"
    if [ -d $WORDPRESS ];then
        tar -czf /var/backups/wordpress/wp-content-backup-${backup_time}.tar.gz /opt/bitnami/apps/wordpress/htdocs/wp-content
        backupDataBase
    else
        echo "Oops, it seems that this server is not a valid WordPress instance"
    fi
}

createFolder() {
    BACKUP="/var/backups/wordpress"
    if [ -d $BACKUP ];then
        backupContent
    else
        mkdir -p /var/backups/wordpress
        backupContent
    fi
}

createFolder