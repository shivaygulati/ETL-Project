##SQOOP COMMAND
sqoop import-all-tables --connect jdbc:mysql://quickstart.cloudera:3306/retail_db --username root --password cloudera --warehouse-dir hdfs:/tmp/retail_db2
echo "ALL tables are imported"

##HIVE DATABASE CREATION AND USE
db_name="retail_db2"

hive -e "create database $db_name"
echo "created database - $db_name"

hive -e "use $db_name"
echo "using database - $db_name"

##HIVE TABLE CREATION
hive -e "create external table $db_name.categories(category_id int, category_department_id int, category_name string) row format delimited fields terminated by ',' stored as textfile location 'hdfs:/tmp/retail_db2/categories';"
echo "created table - categories"

hive -e "create external table $db_name.customers(customer_id int, customer_fname string, customer_lname string, customer_email string, customer_password string, customer_street string, customer_city string, customer_state string, customer_zipcode string) row format delimited fields terminated by ',' stored as textfile location 'hdfs:/tmp/retail_db2/customers';"
echo "created table - customers"

hive -e "create external table $db_name.departments(department_id int, department_name string) row format delimited fields terminated by ',' stored as textfile location 'hdfs:/tmp/retail_db2/departments';"
echo "created table - departments"

hive -e "create external table $db_name.order_items(order_item_id int, order_item_order_id int, order_item_product_id int, order_item_quantity int, order_item_subtotal float, order_item_product_price float) row format delimited fields terminated by ',' stored as textfile location 'hdfs:/tmp/retail_db2/order_items';"
echo "created table - order_items"

hive -e "create external table $db_name.orders(order_id int, order_date timestamp, order_customer_id int, order_status string) row format delimited fields terminated by ',' stored as textfile location 'hdfs:/tmp/retail_db2/orders';"
echo "created table - orders"

hive -e "create external table $db_name.products(product_id int, product_category_id int, product_name string, product_description string, product_price float, product_image string) row format delimited fields terminated by ',' stored as textfile location 'hdfs:/tmp/retail_db2/products';"
echo "created table - products"

##HIVE PARTITION TABLE CREATION

hive -e "create table $db_name.orders1(order_id int, order_customer_id int, order_status string) partitioned by (order_date timestamp);"
echo "created table - orders1"

hive -e "set hive.exec.dynamic.partition = enable;
	 set hive.exec.dynamic.partition.mode = nonstrict;
	 set hive.exec.max.dynamic.partitions = 1000;
	 set hive.exec.max.dynamic.partitions.pernode = 1000;
	 insert into $db_name.orders1 partition(order_date) select order_id,order_customer_id,order_status,order_date from $db_name.orders;"
echo "inserted data in table - orders1"

##PROBLEM STATEMENTS
##CATEGORIES

echo "using table - CATEGORIES"

hive -e "select category_department_id,count(category_name) from $db_name.categories group by category_department_id;" > /home/cloudera/Desktop/project1/categories_problem1.txt
hive -e "select distinct category_department_id from $db_name.categories;" > /home/cloudera/Desktop/project1/categories_problem2.txt
hive -e "select count(*) from $db_name.categories;" > /home/cloudera/Desktop/project1/categories_problem3.txt

##CUSTOMERS

echo "using table - CUSTOMERS"

hive -e "select count(*) from $db_name.customers;" > /home/cloudera/Desktop/project1/customers_problem1.txt
hive -e "select customer_id, concat(customer_fname,' ',customer_lname) as full_name,concat(customer_street,',',customer_city,',',customer_state,',',customer_zipcode) as full_address from $db_name.customers;" > /home/cloudera/Desktop/project1/customers_problem2.txt
hive -e "select customer_state,count(customer_city) from $db_name.customers where customer_state == 'PR' group by customer_state;" > /home/cloudera/Desktop/project1/customers_problem3.txt
hive -e "select distinct customer_zipcode from $db_name.customers;" > /home/cloudera/Desktop/project1/customers_problem4.txt

##DEPARTMENTS

echo "using table - DEPARTMENTS"

hive -e "select count(*) from $db_name.departments;" > /home/cloudera/Desktop/project1/departments_problem1.txt

##ORDER_ITEMS

echo "using table - ORDER_ITEMS"

hive -e "select count(*) from $db_name.order_items;" > /home/cloudera/Desktop/project1/order_items_problem1.txt
hive -e "select order_item_order_id,order_item_quantity from $db_name.order_items order by order_item_quantity desc limit 5;" > /home/cloudera/Desktop/project1/order_items_problem2.txt
hive -e "select order_item_order_id,sum(order_item_subtotal) as total_amount from $db_name.order_items group by order_item_order_id order by total_amount desc limit 5;" > /home/cloudera/Desktop/project1/order_items_problem3.txt
hive -e "select order_item_order_id,collect_set(order_item_id),sum(order_item_subtotal) as total_amount from $db_name.order_items group by order_item_order_id;" > /home/cloudera/Desktop/project1/order_items_problem4.txt

##mysql - select order_item_order_id,group_concat(order_item_id),sum(order_item_subtotal) as total_amount from order_items group by order_item_order_id;

##ORDERS

echo "using table - ORDERS"

hive -e "select count(*) from $db_name.orders;" > /home/cloudera/Desktop/project1/orders_problem1.txt
hive -e "select count(*) from $db_name.orders where order_status == 'CLOSED';" > /home/cloudera/Desktop/project1/orders_problem2.txt
hive -e "select count(*) from $db_name.orders where order_date == '2014-07-19 00:00:00';" > /home/cloudera/Desktop/project1/orders_problem3.txt
hive -e "select order_status,count(order_id) from $db_name.orders group by order_status;" > /home/cloudera/Desktop/project1/orders_problem4.txt

##PRODUCTS

echo "using table - PRODUCTS"

hive -e "select count(*) from $db_name.products;" > /home/cloudera/Desktop/project1/products_problem1.txt
hive -e "select * from $db_name.products order by product_price desc limit 5;" > /home/cloudera/Desktop/project1/products_problem2.txt
hive -e "select product_category_id,count(product_name) as count1 from $db_name.products group by product_category_id order by count1 desc limit 5;" > /home/cloudera/Desktop/project1/products_problem3.txt

##MISCELLANEOUS

echo "using ALL tables"

hive -e "select customer_id, concat(customer_fname,' ',customer_lname) as full_name,concat(customer_street,',',customer_city,',',customer_state,',',customer_zipcode) as full_address from $db_name.customers cust join $db_name.orders ord on cust.customer_id == ord.order_customer_id where ord.order_status == 'CLOSED';" > /home/cloudera/Desktop/project1/miscellaneous_problem1.txt

hive -e "select A.*,category_name from (select dep.department_id,dep.department_name,count(cat.category_name) as count1 from $db_name.departments dep join $db_name.categories cat on dep.department_id == cat.category_department_id group by dep.department_id,dep.department_name)A join $db_name.categories on A.department_id == category_department_id;" > /home/cloudera/Desktop/project1/miscellaneous_problem2.txt

hive -e "select B.order_id,order_date,order_status,B.total_amount,customer_id,concat(customer_fname,' ',customer_lname) as full_name,concat(customer_street,',',customer_city,',',customer_state,',',customer_zipcode) as full_address from (select A.*,order_date,order_customer_id,order_status,order_id from (select order_item_order_id,sum(order_item_subtotal) as total_amount from $db_name.order_items group by order_item_order_id) A join $db_name.orders ord on A.order_item_order_id == ord.order_id) B join $db_name.customers cust on cust.customer_id == B.order_customer_id order by B.total_amount desc limit 100;" > /home/cloudera/Desktop/project1/miscellaneous_problem3.txt
