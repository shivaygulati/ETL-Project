##IMPORT NEW DATA OF ORDERS TABLE

##SQOOP COMMAND
sqoop import --connect jdbc:mysql://quickstart.cloudera:3306/retail_db --username root --password cloudera --table orders --target-dir hdfs:/tmp/orders
echo "Orders table with new data is imported"

##DB details
db_name="retail_db2"

hive -e "use $db_name"
echo "using database - $db_name"

##HIVE TABLE CREATION
hive -e "create external table $db_name.orders_new(order_id int, order_date timestamp, order_customer_id int, order_status string) row format delimited fields terminated by ',' stored as textfile location 'hdfs:/tmp/orders';"
echo "created table - orders_new"

##CDC JOB USING PIG

pig -useHCatalog -e "a = load '$db_name.orders' USING org.apache.hive.hcatalog.pig.HCatLoader();
		     b = load '$db_name.orders_new' USING org.apache.hive.hcatalog.pig.HCatLoader();
		     c = Join a by order_id full outer, b by order_id;
		     SPLIT c into d if b::order_id is null, e if b::order_id is not null;
		     d1 = foreach d generate $0 as (order_id: int),$1 as (order_date: datetime),$2 as (order_customer_id: int),$3 as (order_status: chararray);
		     e1 = foreach e generate $4 as (order_id: int),$5 as (order_date: datetime),$6 as (order_customer_id: int),$7 as (order_status: chararray);
		     f = UNION d1,e1;
		     STORE f INTO '$db_name.orders' USING org.apache.hive.hcatalog.pig.HCatStorer(); 
" 
##> /home/cloudera/Desktop/project1/cdc_problem.txt


##STORE f INTO '$db_name.orders' USING org.apache.hive.hcatalog.pig.HCatStorer();
