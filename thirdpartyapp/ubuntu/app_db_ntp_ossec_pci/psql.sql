
E:\db\psql\save.sql
E:\ubuntu\app_db_ntp_ossec_pci\save.sql

https://13.233.162.247/phpinfo.php

apt update
php -v

https://ubuntu.com/server/docs/databases-postgresql
https://vegibit.com/how-to-use-postgresql-with-php/


apt install php8.2-pgsql -y

apt remove --auto-remove php8.2-pgsql
apt remove php8.2-pgsql
apt remove purge php8.2-pgsql
sudo apt autoclean && sudo apt autoremove


https://www.postgresql.org/download/linux/ubuntu/

apt install postgresql
apt install php8.1-pgsql -y

psql --version

service postgresql status
netstat -tulpn

cd /etc/postgresql/14/main
cp postgresql.conf postgresql.conf_origial
vi postgresql.conf
	listen_addresses = '*'          # what IP address(es) to listen on;
	
cp pg_hba.conf pg_hba.conf_origial
vi pg_hba.conf
	host    all             all             0.0.0.0/0           md5
	
/etc/init.d/postgresql restart
/etc/init.d/postgresql status

systemctl enable postgresql

netstat -lntp | grep postgres
nmap server -p 5432


##############################################################

su - postgres
psql


CREATE DATABASE pgslqdb31 WITH OWNER = postgres ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE pgslqdb31 TO postgres;

##############################################################

cmd
cd C:\Program Files\PostgreSQL\16\bin>

pg_dump -h localhost -p 3306 -U postgres pgwdb > E:\db\pgwdb_23_12_19.sql

pg_dump -h localhost -p 3306 -U postgres -s pgwdb  > E:\db\pgwdb_dump_24_01_20.sql





scp -3 -P 210 -r -i /root/sshPemkey * devtech@172.31.39.54:/home/devtech/upload
scp -3 -P 210 -r -i /root/sshPemkey pgwdb_23_12_19.sql devtech@172.31.39.54:/home/devtech/upload


##############################################################
<<create user and db with privileges --------------

su - postgres
psql

\l
\du
\l
\c pgdb31
\dt

\q

CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb' SUPERUSER;

CREATE DATABASE pgdb31 WITH OWNER = pgslquser ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE pgdb31 TO pgslquser;

http://13.233.162.247/signins/login
http://13.233.162.247/signins/password?id=21

https://pro.i15.me/signins/login
gwadmn
@aA123456789

$_SESSION['adm_login']=1; $_SESSION['login_adm']=1;$_SESSION['sub_admin_id']=21;

$_SESSION['adm_login']=$_SESSION['login_adm']=1;

##############################################################
<<import --------------
pgslquser

psql -h localhost -p 5432 -U pgslquser -d pgdb31 -f pgwdb_23_12_19.sql
yzKtkQnma%samtDzqG2JZML9TRpFb


		psql -h localhost -p 3306 -U postgres -d ipgdb -f E:\db\pgwdb_23_12_19.sql
		psql -h postgres -p 3306 -U postgres -d pgslqdb31 -f /home/devtech/upload/pgwdb_23_12_19.sql
		psql -h localhost -p 3306 -U postgres -d pgslqdb31 -f /home/devtech/upload/pgwdb_23_12_19.sql

##############################################################


psqldump -u postgres -P 3306 pgwdb > E:\db\localhost\pgwdb_23_12_19.sql

pg_dump pgwdb > E:\db\pgwdb_23_12_19.sql
pg_dump pgwdb > E:/db/pgwdb_23_12_19.sql
pg_dump pgwdb > pgwdb_23_12_19.sql;

PostgreSQLdump -u postgres -p pgwdb >E:\db\pgwdb_23_12_19.sql
PostgreSQLdump -u postgres -p pgwdb >E:\db\pgwdb_23_12_19.sql

pg_dump -h localhost -p 3306 -U postgres pgwdb > E:\db\pgwdb_23_12_19.sql

pg_dump –u postgres pgwdb > pgwdb11.pgsql

pg_dump -U postgres pgwdb | psql -U postgres livepgwdb

pg_dump "pgwdb" > C:\pgwdb.pgsql

\q

pg_dump -U postgres pgwdb > pgwdb66.sql

pg_dump -U postgres -d pgwdb -t {sourceTable} > {dump}.sql
pg_dump -U postgres -d pgwdb > pgwdb_23_12_19.sql


cmd
cd C:\Program Files\PostgreSQL\16\pgAdmin 4\runtime

	pg_dump -U postgres -p 3306 -d postgres -W -f E:\db\pgwdb_dump_23_12_19.sql
	yzKtkQnma%samtDzqG2JZML9TRpFb

	pg_dump -U postgres -p 5432 -d postgres -W -f c:\vm\dump.sql

##############################################################



psql -h localhost
psql -U Username postgres
yzKtkQnma%samtDzqG2JZML9TRpFb

create database pgslqdb31;


$db_hostname='172.31.10.183'; //         3306   localhost
$db_username='nextdbuser32';
$db_password='zqG2JZML9TRQnma%samtDpFbyzKtk';//
$db_database='nextgendb32';
$db_tbprefix='zt';



$db_hostname='localhost'; //         3306   localhost
$db_username='pgslquser'; // postgres pgslquser
$db_password='yzKtkQnma%samtDzqG2JZML9TRpFb';//
$db_database='pgslqdb31';
$db_tbprefix='zt';


psql -h localhost



psql -h localhost -p 5432 -U postgress
psql -h 127.0.0.1 -p 5432 -U postgress

yzKtkQnma%samtDzqG2JZML9TRpFb


CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb';

##############################################################

CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb' SUPERUSER;

DROP USER pgslquser;

CREATE USER gwuser SUPERUSER;


##############################################################

su - postgres
psql

CREATE USER pgslquser WITH PASSWORD 'yzKtkQnma%samtDzqG2JZML9TRpFb' SUPERUSER;

CREATE DATABASE pgdb31 WITH OWNER = pgslquser ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE pgdb31 TO pgslquser;

CREATE DATABASE pgslqdb31 WITH OWNER = postgres ENCODING = 'UTF8' CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE pgslqdb31 TO postgres;


