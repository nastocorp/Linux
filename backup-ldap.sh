#!/bin/bash

set -e

BACKUP_PATH=/export/backup
SLAPCAT=/usr/sbin/slapcat


nice ${SLAPCAT} -b cn=config > ${BACKUP_PATH}/config.ldif
if [ $? -ne 0 ]; then
    echo "`date` --> FAILED TO CREATE BACKUP" >> /var/log/backup-ldap.log
else
    echo "`date` --> BACKUP TAKEN" >> /var/log/backup-ldap.log
fi

nice ${SLAPCAT} -b dc=pulttibois,dc=net > ${BACKUP_PATH}/pulttibois.ldif

chown root:root ${BACKUP_PATH}/*
chmod 600 ${BACKUP_PATH}/*.ldif
