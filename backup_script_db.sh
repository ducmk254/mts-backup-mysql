#!/bin/bash
# Lấy ngày hiện tại và tạo biến
date=$(date +%d_%m_%Y_%H_%M_%S)

# Tạo biến cho tên file
filename="mutosi_prod_"$date".sql"
# Lấy bản sao lưu của cơ sở dữ liệu
echo "==========================================="
echo "Step1: backup running ..."
mysqldump -h 10.2.12.174 --user=mts_backup --password=Mts@******** --default-character-set=utf8 mutosi_prod > "/opt/mutosi-db-backup/$filename" # luu y thay password
echo "backup finish ..."
echo "uploading to s3 ..."
cd /opt/mutosi-db-backup/
s3cmd put $filename  s3://mutosi-db-backup
echo "uploading finish !!!"
rm -r $filename
echo "==========================================="

# crotnab , add new line :
# 30 1 * * * /root/backup_script_db.sh > /dev/null 2>&1
