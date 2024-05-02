#!/bin/bash

echo '-------- CREATING DATABASE TABLES... --------'
mysql -u USERNAME -pPASSWORD < /sql/schema.sql
echo '-------- INSERTING DATABASE TABLES... --------'
mysql -u USERNAME -pPASSWORD < /sql/insert.sql
