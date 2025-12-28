#!/bin/bash
# backup_restore.sh
# Script pour sauvegarde, restauration et optimisation MySQL

DB_NAME="universite"
BACKUP_DIR="$HOME/mysql_backups"
mkdir -p $BACKUP_DIR

# -------------------
# Sauvegarde complète
# -------------------
mysqldump -u root -p --routines --triggers --events --single-transaction \
  $DB_NAME > $BACKUP_DIR/${DB_NAME}_full.sql

echo "Sauvegarde complète terminée : $BACKUP_DIR/${DB_NAME}_full.sql"

# -------------------
# Analyse et optimisation
# -------------------
mysql -u root -p -e "USE $DB_NAME; ANALYZE TABLE INSCRIPTION; OPTIMIZE TABLE INSCRIPTION;"

echo "Analyse et optimisation terminées"

# -------------------
# Restauration test
# -------------------
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME}_test;"
mysql -u root -p $DB_NAME"_test" < $BACKUP_DIR/${DB_NAME}_full.sql
echo "Restauration test terminée"
