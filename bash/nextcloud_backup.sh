#/bin/bash

date=`date +"%Y%m%d"`
date_time=`date +%F__%H_%M_%S`
username=backup
password=zuZv7v9jmyHDM5Lc
alert_emails=ousenko@pzu.com.ua,mvaschenko@pzu.com.ua

/usr/bin/sudo -u apache /bin/php /var/www/sites/nextcloud/occ maintenance:mode --on 
mkdir -p /data/BACKUP/nextcloud-backup_$date

/usr/bin/mysqldump --single-transaction -u $username -p"$password" nextcloud > /data/BACKUP/nextcloud-backup_$date/nextcloud-sqlbkp_`date +"%Y%m%d"`.bak

if [ "$?" -ne "0" ];
then
 echo "[ERROR] mysql dump failed" 1>&2
 echo -e "$date_time Backup: --> FAILED <-- Nextcloud/mysql. Check it, bro!" | mail -r "<cloud@pzu.com.ua >" -s "Backup: --> FAILED <-- Nextcloud/mysql" $alert_emails 
 /usr/bin/sudo -u apache /bin/php "/var/www/sites/nextcloud/occ" maintenance:mode --off
 exit 1 
else
 echo "[OK] mysql dump succeeded" 1>&2
 echo -e "$date_time Backup: --> OK <-- Nextcloud/mysql" | mail -r "<cloud@pzu.com.ua >" -s "Backup: --> OK <-- Nextcloud/mysql" $alert_emails 
 /usr/bin/sudo -u apache /bin/php "/var/www/sites/nextcloud/occ" maintenance:mode --off
fi
