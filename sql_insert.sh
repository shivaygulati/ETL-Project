DB_USER='root';
DB_PASSWD='cloudera';

DB_NAME='retail_db';
TABLE='orders';

##mysql commands
mysql --user=$DB_USER --password=$DB_PASSWD $DB_NAME <<EOF
insert into orders values (68884,'2017-11-23 00:00:00',1111,'COMPLETE');
insert into orders values (68885,'2017-11-23 00:00:00',1222,'COMPLETE');
insert into orders values (68886,'2017-11-23 00:00:00',1223,'COMPLETE');
insert into orders values (68887,'2017-11-23 00:00:00',1224,'COMPLETE');
insert into orders values (68888,'2017-11-23 00:00:00',1225,'COMPLETE');
insert into orders values (68889,'2017-11-23 00:00:00',1226,'COMPLETE');
insert into orders values (68890,'2017-11-23 00:00:00',1227,'COMPLETE');
insert into orders values (68891,'2017-11-23 00:00:00',1228,'COMPLETE');
insert into orders values (68892,'2017-11-23 00:00:00',1229,'COMPLETE');
insert into orders values (68893,'2017-11-23 00:00:00',1230,'COMPLETE');
insert into orders values (68894,'2017-11-23 00:00:00',1231,'COMPLETE');
insert into orders values (68895,'2017-11-23 00:00:00',1232,'COMPLETE');
insert into orders values (68896,'2017-11-23 00:00:00',1233,'COMPLETE');
insert into orders values (68897,'2017-11-23 00:00:00',1234,'COMPLETE');
insert into orders values (68898,'2017-11-23 00:00:00',1235,'COMPLETE');
insert into orders values (68899,'2017-11-23 00:00:00',1236,'COMPLETE');
insert into orders values (68900,'2017-11-23 00:00:00',1237,'COMPLETE');
insert into orders values (68901,'2017-11-23 00:00:00',1238,'COMPLETE');
insert into orders values (68902,'2017-11-23 00:00:00',1239,'COMPLETE');
insert into orders values (68903,'2017-11-23 00:00:00',1240,'COMPLETE');
insert into orders values (68904,'2017-11-23 00:00:00',1241,'COMPLETE');
insert into orders values (68905,'2017-11-23 00:00:00',1242,'COMPLETE');
insert into orders values (68906,'2017-11-23 00:00:00',1243,'COMPLETE');
insert into orders values (68907,'2017-11-23 00:00:00',1244,'COMPLETE');
insert into orders values (68908,'2017-11-23 00:00:00',1245,'COMPLETE');
insert into orders values (68909,'2017-11-23 00:00:00',1246,'COMPLETE');
insert into orders values (68910,'2017-11-23 00:00:00',1247,'COMPLETE');
insert into orders values (68911,'2017-11-23 00:00:00',1248,'COMPLETE');
EOF

##OR

##mysql --user=$DB_USER --password=$DB_PASSWD $DB_NAME -e "insert into orders values (68884,'2017-11-23 00:00:00',1111,'COMPLETE'); insert into orders values (68885,'2017-11-23 00:00:00',1222,'COMPLETE'); insert into orders values (68886,'2017-11-23 00:00:00',1223,'COMPLETE'); insert into orders values (68887,'2017-11-23 00:00:00',1224,'COMPLETE'); insert into orders values (68888,'2017-11-23 00:00:00',1225,'COMPLETE'); insert into orders values (68889,'2017-11-23 00:00:00',1226,'COMPLETE'); insert into orders values (68890,'2017-11-23 00:00:00',1227,'COMPLETE'); insert into orders values (68891,'2017-11-23 00:00:00',1228,'COMPLETE'); insert into orders values (68892,'2017-11-23 00:00:00',1229,'COMPLETE'); insert into orders values (68893,'2017-11-23 00:00:00',1230,'COMPLETE'); insert into orders values (68894,'2017-11-23 00:00:00',1231,'COMPLETE'); insert into orders values (68895,'2017-11-23 00:00:00',1232,'COMPLETE'); insert into orders values (68896,'2017-11-23 00:00:00',1233,'COMPLETE'); insert into orders values (68897,'2017-11-23 00:00:00',1234,'COMPLETE'); insert into orders values (68898,'2017-11-23 00:00:00',1235,'COMPLETE'); insert into orders values (68899,'2017-11-23 00:00:00',1236,'COMPLETE'); insert into orders values (68900,'2017-11-23 00:00:00',1237,'COMPLETE'); insert into orders values (68901,'2017-11-23 00:00:00',1238,'COMPLETE'); insert into orders values (68902,'2017-11-23 00:00:00',1239,'COMPLETE'); insert into orders values (68903,'2017-11-23 00:00:00',1240,'COMPLETE'); insert into orders values (68904,'2017-11-23 00:00:00',1241,'COMPLETE'); insert into orders values (68905,'2017-11-23 00:00:00',1242,'COMPLETE'); insert into orders values (68906,'2017-11-23 00:00:00',1243,'COMPLETE'); insert into orders values (68907,'2017-11-23 00:00:00',1244,'COMPLETE'); insert into orders values (68908,'2017-11-23 00:00:00',1245,'COMPLETE'); insert into orders values (68909,'2017-11-23 00:00:00',1246,'COMPLETE'); insert into orders values (68910,'2017-11-23 00:00:00',1247,'COMPLETE'); insert into orders values (68911,'2017-11-23 00:00:00',1248,'COMPLETE'); "
