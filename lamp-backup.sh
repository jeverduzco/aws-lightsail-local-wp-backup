#!/usr/bin/env bash
# This script only backup the wp-content folder and database
set -e

backup_time=$(date +"%Y-%m-%d-%H%M%S")

echo "Initializing the backup copy"

fixPremissions() {
    chown bitnami:bitnami -R /var/backups/lamp
    echo "Backup complete!"
}

backupDataBase() {
    mysql_password=`cat /home/bitnami/bitnami_application_password`
    mysqldump -h"localhost" -u"root" -p"${mysql_password}" --quick --opt --single-transaction -A > /var/backups/lamp/databases-backup-${backup_time}.sql
    fixPremissions
}

backupContent() {
    LAMP="/opt/bitnami/apps"
    if [ -d $LAMP ];then
        tar -czf /var/backups/lamp/lamp-content-backup-${backup_time}.tar.gz /opt/bitnami/apps
        backupDataBase
    else
        echo "Oops, it seems that this server is not a valid LAMP instance"
    fi
}

createFolder() {
    BACKUP="/var/backups/lamp"
    if [ -d $BACKUP ];then
        backupContent
    else
        mkdir -p /var/backups/lamp
        backupContent
    fi
}

createFolder