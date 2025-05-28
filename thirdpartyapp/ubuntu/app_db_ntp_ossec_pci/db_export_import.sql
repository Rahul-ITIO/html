lsof +L1
sudo killall -9 mysqld

show full processlist
show processlist


tail -f /var/log/apache2/access.log

<<apache issue 
journalctl -xe

sudo ps aux | grep -E 'apache2|httpd'

sudo killall apache2

killall -9 apache2

/etc/init.d/apache2 restart
/etc/init.d/apache2 status
systemctl reload apache2
systemctl restart apache2

ps aux --sort=-%mem | head
ps aux --sort=-%mem
free -mh
apt update
apt-get upgrade
free -mh
systemctl restart apache2.service
ps aux --sort=-%mem

#####################################################################
<<mysql history query <<history

 cat ~/.mysql_history
 

Fatal error: Uncaught mysqli_sql_exception: Lock wait timeout exceeded; try restarting transaction in

/etc/init.d/mysql restart
service mysql restart
/etc/init.d/mysql status

mysql
    SELECT NOW();
	SELECT @@global.time_zone;

<<Export from Old DB ----------------------------

select id,transaction_id from zt_transactions order by id desc limit 2\G
select * from zt_transactions where transaction_id in (2891471633,2891471745)\G

mysqldump -u root -p  nextgendb1 > nextgendb1_data_2023_05_22.sql
s81bY7zKEDgpYKEgYFRpYFRv

zip -r nextgendb1_data_2023_05_18.zip nextgendb1_data_2023_05_18.sql

<<on Jump server from DB 
scp -3 -P 210 -r -i /root/sshPemkey  mithlb@172.31.7.178:/home/mithlb/upload/nextgendb1_data_2023_05_22.zip /home/mithlb/upload

ssh -p 210 -i /root/sshPemkey mithlb@172.31.7.178


<<on Jump server to new DB 
scp -3 -P 210 -r -i /root/sshPemkey  nextgendb1_data_2023_05_22.zip ubuntu@172.31.13.56:/home/ubuntu/

ssh -p 210 -i /root/sshPemkey ubuntu@172.31.13.56




<<Host Base on App run command and check db conection via private ip of DB

mysql -h 172.31.13.56 -u next999dbuser22 -p
s81bY7zKEDgpYKEgYFRpYFRv


<<Import on NEW DB Server ----------------------------
ssh -p 210 -i /root/sshPemkey ubuntu@172.31.13.56
apt install mysql-server


/etc/init.d/mysql stop
vi /etc/mysql/mysql.conf.d/mysqld.cnf

/etc/init.d/mysql restart
service mysql restart
/etc/init.d/mysql status
	
[mysqld] 
bind-address           = 0.0.0.0
sql_mode = ""
group_concat_max_len = 100000
default-time-zone = "+08:00"
binlog_expire_logs_seconds = 86400
max_binlog_size = 104857600  


key_buffer_size         = 128M
max_connections        = 1000000
table_open_cache       = 4000

tmp_table_size        = 64M
max_heap_table_size   = 32M
event_scheduler=on

#query_cache_limit     = 1M
#query_cache_size      = 32M


default-time-zone = "+08:00" // Singapore
default-time-zone = "+05:30" // India

binlog_expire_logs_seconds = 86400  # 86400 = 60*60*24*1 = 1 day
max_binlog_size = 104857600  



/etc/init.d/mysql restart
service mysql restart
/etc/init.d/mysql status

<<https://galaxydata.ru/mysqlcalc/
MySQL Memory Calculator
key_buffer_size calculator

$db_hostname='172.31.7.178';
$db_username='next999dbuser22';
$db_password='s81bY7zKEDgpYKEgYFRpYFRv';

$db_database='nextgendb1';
		

mysql -u root -p
s81bY7zKEDgpYKEgYFRpYFRv

CREATE DATABASE nextgendb1;
show databases;
use nextgendb1;
show tables;


<< APP1_NextGen_php8	next999dbuser22 -----------------------------------
	
	SET GLOBAL validate_password.policy = 0;
	
CREATE USER 'next999dbuser22'@'172.31.26.176' IDENTIFIED BY 's81bY7zKEDgpYKEgYFRpYFRv';
SHOW GRANTS FOR 'next999dbuser22'@'172.31.26.176';
GRANT ALL ON nextgendb1.* TO 'next999dbuser22'@'172.31.26.176';
FLUSH PRIVILEGES;
commit;
		
	SHOW GRANTS FOR 'next999dbuser22'@'172.31.26.176';
	
	show processlist;
	
	db_password='s81bY7zKEDgpYKEgYFRpYFRv';
	
	
<<APP2_NextGen_php8	next999dbuser22 ---------------------------
	
SET GLOBAL validate_password.policy = 0;
CREATE USER 'next999dbuser22'@'172.31.30.83' IDENTIFIED BY 's81bY7zKEDgpYKEgYFRpYFRv';
SHOW GRANTS FOR 'next999dbuser22'@'172.31.30.83';
GRANT ALL ON nextgendb1.* TO 'next999dbuser22'@'172.31.30.83';
FLUSH PRIVILEGES;
commit;
		
	SHOW GRANTS FOR 'next999dbuser22'@'172.31.30.83';
	
	show processlist;
	
	db_password='s81bY7zKEDgpYKEgYFRpYFRv';
	

---------------------------------------------------

<<import 

mysql -p -u root nextgendb1 < nextgendb1_data_2023_05_22.sql
s81bY7zKEDgpYKEgYFRpYFRv

/etc/init.d/mysql restart
service mysql restart
/etc/init.d/mysql status



<<setup new db 

<<port change 210 ---------------------------------------
			
					grep -i port /etc/ssh/sshd_config

					netstat -tulpn | grep ssh
					/etc/init.d/ssh status

					/etc/init.d/ssh restart

					vi /etc/ssh/sshd_config
						Port 210
					grep -i port /etc/ssh/sshd_config

					cat /dev/null > auth.log
					
					service sshd restart
					service ssh restart

					/etc/init.d/ssh restart
			
			<<strong ssl 1
			
				# vi /etc/ssh/sshd_config

				UsePAM yes


Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
MACs hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha2-256,hmac-sha2-512

service sshd restart
service ssh restart

/etc/init.d/ssh restart


ssh -p 210 -i /root/sshPemkey ubuntu@172.31.13.56


<<clear cache final free ram memory -----------------------------------------
free -mh	
cd /root
vi clearcache.sh
#!/bin/sh
sync; echo 3 > /proc/sys/vm/drop_caches
		
chmod 755 /root/clearcache.sh

crontab -e
	
*/1 * * * * /root/clearcache.sh

/etc/init.d/cron restart
/etc/init.d/cron status
free -mh

crontab -e

crontab -l

ls -lF /var/lib/mysql | grep '#'

chage -l devtech
chage -m 1 -M 90 -W 7 devtech




<<swapfile 6G 

swapoff -a	

sudo dd if=/dev/zero of=/swapfile bs=1G count=6 status=progress

	6442450944 bytes (6.4 GB, 6.0 GiB) copied, 46 s, 139 MB/s
	6+0 records in
	6+0 records out
	6442450944 bytes (6.4 GB, 6.0 GiB) copied, 48.8711 s, 132 MB/s

chown root:root /swapfile	
chmod 600 /swapfile

mkswap /swapfile
	Setting up swapspace version 1, size = 5 GiB (5368705024 bytes)
	no label, UUID=caf84116-f92e-4d9d-bacb-544da83623a2
	
##Finally enable the SWAP.
swapon /swapfile
swapon --show
	/swapfile file   5G   0B   -2

cp /etc/fstab /etc/fstab.bak
cat /etc/fstab
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

cat /etc/fstab
	LABEL=cloudimg-rootfs   /        ext4   defaults,discard        0 0
cp /etc/fstab /etc/fstab.bak


mount -a
apt update
apt upgrade
reboot
	

########------------------------



<<swapfile	| memory sweep mod in ubuntu 22.04

https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-22-04


####### Step 3 – Creating a Swap File  -------------------
ls -ld /swapfile
	-rw------- 1 root root 8589918208 Oct 21 10:00 /swapfile

swapoff -a	

sudo dd if=/dev/zero of=/swapfile bs=16G count=10 status=progress

dd if=/dev/zero of=/swapfile bs=1G count=4
	0+4 records in
	0+4 records out
	8589918208 bytes (8.6 GB, 8.0 GiB) copied, 67.5797 s, 127 MB/s

chown root:root /swapfile
chmod 0600 /swapfile
	chmod 0600 /swapfile
mkswap /swapfile
	Setting up swapspace version 1, size = 8 GiB (8589914112 bytes)
	no label, UUID=97a415cc-2bfd-49ce-af12-68eef93a479e
	
####### Step 4 – Enabling the Swap File in free -mh -------------------
swapon -s
swapon /swapfile
swapon --show
	NAME      TYPE SIZE USED PRIO
	/swapfile file   8G   0B   -2
	
	
####### Step 5 – Making the Swap File Permanent ------------------------
cat /etc/fstab
	LABEL=cloudimg-rootfs   /        ext4   defaults,discard        0 0
cp /etc/fstab /etc/fstab.bak

 
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
cat /etc/fstab
	LABEL=cloudimg-rootfs   /        ext4   defaults,discard        0 0
	/swapfile none swap sw 0 0
	
OR 

vi /etc/fstab ### for add to last line 
	/swapfile  swap  swap  defaults 0 0
mount -a

free -mh
			  total        used        free      shared  buff/cache   available
Mem:           30Gi       4.3Gi        26Gi       3.0Mi       172Mi        26Gi
Swap:         8.0Gi          0B       8.0Gi

mount -a
apt update
apt upgrade
reboot

######## Disable swapfile  ------------------------ https://askubuntu.com/questions/920595/fallocate-fallocate-failed-text-file-busy-in-ubuntu-17-04

###commented, before you start the changes disable the use of swap:

swapoff -a	

sudo dd if=/dev/zero of=/swapfile bs=1G count=10 status=progress




######## other ------------------------

mkdir -p /swapfile
ls -ld  /swapfile
rm -rf /swapfile/


ls -ld /swapfile
	-rw------- 1 root root 8589918208 Oct 21 10:00 /swapfile

dd if=/dev/zero of=/swapfile bs=1G count=8
	8+0 records in
	8+0 records out
	8589934592 bytes (8.6 GB, 8.0 GiB) copied, 107.462 s, 79.9 MB/s


########------------------------

<<swapfile 16G 

swapoff -a	

sudo dd if=/dev/zero of=/swapfile bs=16G count=10 status=progress

	21474795520 bytes (21 GB, 20 GiB) copied, 130 s, 166 MB/s
	0+10 records in
	0+10 records out
	21474795520 bytes (21 GB, 20 GiB) copied, 164.456 s, 131 MB/s

chown root:root /swapfile	
chmod 600 /swapfile

mkswap /swapfile
	Setting up swapspace version 1, size = 20 GiB (21474791424 bytes)
	no label, UUID=3bd57c0f-5fb4-4ac7-a916-d56e83fc3fbe
	
##Finally enable the SWAP.
swapon /swapfile
swapon --show
	/swapfile file  20G   0B   -2

cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

cat /etc/fstab
	LABEL=cloudimg-rootfs   /        ext4   defaults,discard        0 0
cp /etc/fstab /etc/fstab.bak


mount -a
apt update
apt upgrade
reboot
	

########------------------------
180
360

<<swapfile 360G 

After final upgrade instance details 
1 - DB server - instance type c5.24xlarge
92vCPU and 192GB RAM
Storage 750 GB
IOPS 37500
Throughput 1000

2 - App server 
Instance type C5.9xlarge
36vCPU and 72 GB RAM
IOPS 8000, throughput 500 and storage 100GB

3 - NTP server - instance type t3-2xlarge
8vCPU 32 GB Memory


mithur




swapoff -a	

sudo dd if=/dev/zero of=/swapfile bs=180G count=200 status=progress
	2147479552 bytes (2.1 GB, 2.0 GiB) copied, 2 s, 989 MB/s
	dd: warning: partial read (2147479552 bytes); suggest iflag=fullblock
	429495910400 bytes (429 GB, 400 GiB) copied, 658 s, 652 MB/s
	0+200 records in
	0+200 records out
	429495910400 bytes (429 GB, 400 GiB) copied, 712.948 s, 602 MB/s


chown root:root /swapfile	
chmod 600 /swapfile

mkswap /swapfile
	Setting up swapspace version 1, size = 400 GiB (429495906304 bytes)
	no label, UUID=2f4b8193-6a48-4552-9a72-b53bfb187376
	
##Finally enable the SWAP.
swapon /swapfile
swapon --show
	NAME      TYPE SIZE USED PRIO
	/swapfile file 400G   0B   -2

cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

cat /etc/fstab
	LABEL=cloudimg-rootfs   /        ext4   defaults,discard        0 0
cp /etc/fstab /etc/fstab.bak



mount -a

apt update
apt upgrade
reboot
	

<<increase disk space by volume is mounted in digitalocean

https://severalnines.com/database-blog/my-mysql-database-out-disk-space

df -h -x tmpfs -x devtmpfs

cd /var/log
find . -type f -size +5M -exec du -sh {} +


df -h /var/lib/mysql


mysql> SET GLOBAL expire_logs_days = 1;
mysql> SET global max_connections = 1000000;

SET PERSIST binlog_expire_logs_seconds = (60*60*24*1);

vi /etc/mysql/mysql.conf.d/mysqld.cnf
			
		
[mysqld]
disable_log_bin
log_bin =                           # turn off
binlog_expire_logs_seconds = 86400  # 86400 = 60*60*24*1 = 1 day
max_binlog_size = 104857600  
innodb_lock_wait_timeout=120

or 

mysql> show variables like 'innodb_lock_wait_timeout';
mysql> SET GLOBAL innodb_lock_wait_timeout = 120; 



cd /var/lib/mysql/binlog.000573

sudo cat /dev/null > /var/log/mysql/query.log

innodb_lock_wait_timeout=120
 
 binlog no need to be 2 days back 

/etc/init.d/mysql restart
/etc/init.d/mysql status
service mysql restart

sudo su 
cd /var/lib/apt/lists/
rm -fr *
cd /etc/apt/sources.list.d/
rm -fr *
cd /etc/apt
cp sources.list sources.list.old
cp sources.list sources.list.tmp
sed 's/ubuntuarchive.hnsdc.com/us.archive.ubuntu.com/' sources.list.tmp | sudo tee sources.list
sudo rm sources.list.tmp*
apt clean
apt update


apt-get clean
apt-get update
apt-get upgrade
apt upgrade

reboot


#####################################################################



  251  systemctl stop  mysql
  252  vim /etc/mysql/mysql.conf.d/mysqld.cnf
  253  cat /proc/meminfo
  254  tail -100 /var/log/kern.log
  255  ps  -aux --sort -rss|head -5
  
  https://www.faqforge.com/linux/optimize-mysql-performance-with-mysqltuner/?ajaxifyLazyLoadEnable=null&nonce=null&post_id=null&WPACFallback=1&WPACRandom=1698811625749
  
#query_cache_limit     = 1M
#query_cache_size      = 32M
tmp_table_size        = 64M
max_heap_table_size   = 32M

  
  https://hevodata.com/learn/mysqltuner/
  perl mysqltuner.pl --buffers --dbstat --idxstat --sysstat --pfstat --tbstat
  
  << 256  wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/mysqltuner.pl
  systemctl stop  mysql
  257  ls
  258  chmod +x mysqltuner.pl
  259  ./mysqltuner.pl
  260  rm mysqltuner.pl
  261  vim /etc/mysql/mysql.conf.d/mysql.cnf
  262  vim /etc/mysql/mysql.conf.d/mysqld.cnf
  
  263  df -h
  264  free
  265  free -h
  266  vim /etc/mysql/mysql.conf.d/mysqld.cnf
  267  systemctl stop  mysql
  268  systemctl start  mysql
  269  ps -eaf |grep mysql
  270  tail -f error.log
  271  systemctl stop  mysql
  272  cd
  273  ll
  274  history
  
  
  perl mysqltuner.pl --buffers --dbstat --idxstat --sysstat --pfstat --tbstat
  
  
<<Expired date range ###########################################################

UPDATE `zt_master_trans_table` AS `t`  SET `t`.`trans_status`='22'  WHERE `t`.`trans_status` IN (0) AND ( `tdate` BETWEEN (DATE_FORMAT('2023-11-10 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('2023-11-13 23:59:59', '%Y%m%d%H%i%s')) ) LIMIT 2 ;


SELECT COUNT(`ID`)  FROM  `zt_master_trans_table` AS `t` WHERE `t`.`trans_status` IN (0) AND ( `tdate` BETWEEN (DATE_FORMAT('2023-11-10 00:00:00', '%Y%m%d%H%i%s')) AND (DATE_FORMAT('2023-11-13 23:59:59', '%Y%m%d%H%i%s')) ) LIMIT 1 ;


<<EVENT add in config of ###########################################################
[mysqld]
sql_mode = ""
group_concat_max_len = 100000
default-time-zone = "+05:30"

key_buffer_size       = 128M
max_connections       = 1000000
table_open_cache      = 4000

tmp_table_size        = 64M
max_heap_table_size   = 32M
event_scheduler       = on

/etc/init.d/mysql restart
service mysql restart
/etc/init.d/mysql status

SHOW EVENTS;  show variables like 'event_scheduler';

ALTER EVENT trans_auto_expired DISABLE;
ALTER EVENT trans_auto_expired_event DISABLE;

DROP EVENT trans_auto_expired_event;


mysql> SET GLOBAL event_scheduler = ON;
mysql> SHOW VARIABLES like 'event_scheduler';


<<Auto Expired <<auto trans via event EVERY 10 SECOND hard code 

CREATE EVENT trans_auto_expired_event
ON SCHEDULE
  EVERY 1 MINUTE 
DO	
UPDATE `gwnextgendb2`.`zt_master_trans_table` AS `t`  SET `t`.`trans_status`='22'  WHERE `t`.`trans_status` IN (0) AND `t`.`tdate` < now() - interval 10 minute;


SHOW EVENTS\G


<<Auto Expired <<auto trans via event EVERY 10 SECOND or EVERY 1 MINUTE 

CREATE EVENT trans_auto_expired_event
ON SCHEDULE
  EVERY 1 MINUTE
DO	
UPDATE `zt_master_trans_table` AS `t`, `zt_acquirer_table` AS `a` SET `t`.`trans_status`='22'  WHERE `t`.`trans_status` IN (0) AND  `t`.`acquirer`=`a`.`acquirer_id`  AND `t`.`tdate` < now() - interval `a`.`trans_auto_expired` minute LIMIT 5;


SHOW EVENTS;

#########################################################################

<<Auto Expired <<auto trans 

UPDATE `zt_master_trans_table` AS `t`, `zt_acquirer_table` AS `a` SET `t`.`trans_status`='22'  WHERE `t`.`trans_status` IN (0) AND  `t`.`acquirer`=`a`.`acquirer_id`  AND `t`.`tdate` <= now() - interval `a`.`trans_auto_expired` minute ORDER BY `t`.`tdate` DESC LIMIT 5;


UPDATE `zt_master_trans_table` AS `t`, `zt_acquirer_table` AS `a` SET `t`.`trans_status`='22', `t`.`tdate`=now()  WHERE `t`.`trans_status` IN (0) AND  `t`.`acquirer`=`a`.`acquirer_id`  AND `t`.`tdate` <= now() - interval `a`.`trans_auto_expired` minute ORDER BY `t`.`tdate` DESC LIMIT 5;


#########################################################################

SELECT * FROM `zt_master_trans_table` AS `t`, `zt_acquirer_table` AS `a` WHERE `t`.`trans_status` IN (0)  AND  `t`.`acquirer`=`a`.`acquirer_id`  AND `t`.`tdate` <= now() - interval `a`.`trans_auto_expired` minute ORDER BY `t`.`tdate` DESC LIMIT 5;

GROUP BY `t`.`id` 

SELECT * FROM `zt_master_trans_table` AS `t`, `zt_acquirer_table` AS `a` WHERE `t`.`trans_status` IN (0) AND  `t`.`acquirer`=`a`.`acquirer_id`  AND `t`.`tdate` <= now() - interval 30 minute ORDER BY `t`.`tdate` DESC LIMIT 5;


#########################################################################

SELECT * FROM `zt_master_trans_table` WHERE `trans_status` IN (0) AND `tdate` <= now() - interval 30 minute ORDER BY `tdate` DESC LIMIT 5;

SELECT * FROM `zt_master_trans_table` WHERE `trans_status` IN (0) AND `tdate` > now() - interval 30 minute ORDER BY `tdate` DESC LIMIT 5;

SELECT * FROM `zt_master_trans_table` WHERE `trans_status` IN (0) AND `tdate` BETWEEN NOW() - INTERVAL 30 MINUTE AND NOW()  ORDER BY `tdate` DESC LIMIT 5;


#########################################################################


#########################################################################
	
	MySql Event Scheduler Call PHP Script
	
DELIMITER $$
CREATE EVENT testEvent
ON SCHEDULE EVERY 1 minute STARTS '2014-01-01 03:00:00' 
DO BEGIN
  /*
  INSERT INTO test(text) VALUES ('text');* <- THIS WORKS JUST FINE
  */
  SET @exec_var = sys_exec('c:\wamp\bin\php\php5.4.12\php c:\mySite\testit.php');
END $$
DELIMITER;


	

#####################################################################

<<backup cron tab

	https://linuxize.com/post/how-to-back-up-and-restore-mysql-databases-with-mysqldump/
		
		https://www.comentum.com/mysqldump-cron.html
		
		And add one of the following lines depending on your situation. This schedule the backup on 1am every day.

		Remote Host Backup with linked PATH to mysqldump:
		0 1 * * * mysqldump -h mysql.host.com -uusername -ppassword --opt database > /path/to/directory/filename.sql

		Remote Host Backup:
		0 1 * * * /usr/local/mysql/bin/mysqldump -h mysql.host.com -uusername -ppassword --opt database > /path/to/directory/filename.sql

		Local Host mysql Backup:
		0 1 * * * /usr/local/mysql/bin/mysqldump -uroot -ppassword --opt database > /path/to/directory/filename.sql

		(There is no space between the -p and password or -u and username - replace root with a correct database username.)




#####################################################################
<<secure mysql 
https://vpsie.com/knowledge-base/securing-a-mysql-database-in-a-shared-hosting-environment/

E:\ubuntu\secure on mysql.docx

show databases;
drop database test;


 
 
#####################################################################
<<mysql history query <<history

 cat ~/.mysql_history
 
 
#####################################################################

# Here follows entries for some specific programs

# The MySQL server
[mysqld]
user = mysql
port=3306
socket		= /opt/lampp/var/mysql/mysql.sock
skip-external-locking
key_buffer = 512M
max_allowed_packet = 1M
table_open_cache = 64
sort_buffer_size = 512K
net_buffer_length = 8K
read_buffer_size = 256K
read_rnd_buffer_size = 512K
myisam_sort_buffer_size = 8M

# Where do all the plugins live
plugin_dir = /opt/lampp/lib/mysql/plugin/

# Don't listen on a TCP/IP port at all. This can be a security enhancement,
# if all processes that need to connect to mysqld run on the same host.
# All interaction with mysqld must be made via Unix sockets or named pipes.
# Note that using this option without enabling named pipes on Windows
# (via the "enable-named-pipe" option) will render mysqld useless!
# 
# commented in by xampp security
#skip-networking
skip-networking

# Replication Master Server (default)
# binary logging is required for replication
# log-bin deactivated by default since XAMPP 1.4.11
#log-bin=mysql-bin

# required unique id between 1 and 2^32 - 1
# defaults to 1 if master-host is not set
# but will not function as a master if omitted
server-id	= 1

# Replication Slave (comment out master section to use this)
#
# To configure this host as a replication slave, you can choose between
# two methods :
#
# 1) Use the CHANGE MASTER TO command (fully described in our manual) -
#    the syntax is:
#
#    CHANGE MASTER TO MASTER_HOST=<host>, MASTER_PORT=<port>,
#    MASTER_USER=<user>, MASTER_PASSWORD=<password> ;
#
#    where you replace <host>, <user>, <password> by quoted strings and
#    <port> by the master's port number (3306 by default).
#
#    Example:
#
#    CHANGE MASTER TO MASTER_HOST='125.564.12.1', MASTER_PORT=3306,
#    MASTER_USER='joe', MASTER_PASSWORD='secret';
#
# OR
#
# 2) Set the variables below. However, in case you choose this method, then
#    start replication for the first time (even unsuccessfully, for example
#    if you mistyped the password in master-password and the slave fails to
#    connect), the slave will create a master.info file, and any later
#    change in this file to the variables' values below will be ignored and
#    overridden by the content of the master.info file, unless you shutdown
#    the slave server, delete master.info and restart the slaver server.
#    For that reason, you may want to leave the lines below untouched
#    (commented) and instead use CHANGE MASTER TO (see above)
#
# required unique id between 2 and 2^32 - 1
# (and different from the master)
# defaults to 2 if master-host is set
# but will not function as a slave if omitted
#server-id       = 2
#
# The replication master for this slave - required
#master-host     =   <hostname>
#
# The username the slave will use for authentication when connecting
# to the master - required
#master-user     =   <username>
#
# The password the slave will authenticate with when connecting to
# the master - required
#master-password =   <password>
#
# The port the master is listening on.
# optional - defaults to 3306
#master-port     =  <port>
#
# binary logging - not required for slaves, but recommended
#log-bin=mysql-bin


# Point the following paths to different dedicated disks
#tmpdir		= /tmp/		
#log-update 	= /path-to-dedicated-directory/hostname

# Uncomment the following if you are using BDB tables
#bdb_cache_size = 4M
#bdb_max_lock = 10000

# Comment the following if you are using InnoDB tables
#skip-innodb
innodb_data_home_dir = /opt/lampp/var/mysql/
innodb_data_file_path = ibdata1:10M:autoextend
innodb_log_group_home_dir = /opt/lampp/var/mysql/
# You can set .._buffer_pool_size up to 50 - 80 %
# of RAM but beware of setting memory usage too high
innodb_buffer_pool_size = 16M
# Deprecated in 5.6
#innodb_additional_mem_pool_size = 2M
# Set .._log_file_size to 25 % of buffer pool size
innodb_log_file_size = 5M
innodb_log_buffer_size = 8M
innodb_flush_log_at_trx_commit = 1
innodb_lock_wait_timeout = 50

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash
# Remove the next comment character if you are not familiar with SQL
#safe-updates

[isamchk]
key_buffer = 20M
sort_buffer_size = 20M
read_buffer = 2M
write_buffer = 2M

[myisamchk]
key_buffer = 20M
sort_buffer_size = 20M
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout


#####################################################################
#####################################################################
#####################################################################


#####################################################################

systemctl daemon-reload
systemctl restart mysqld  # RPM platforms
systemctl restart mysql   # Debian platforms

