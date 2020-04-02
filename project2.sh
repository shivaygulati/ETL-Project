##DB details
db_name="retail_db2"
echo "using database - $db_name"
##CDC JOB USING PIG

pig -useHCatalog -e "a = load '$db_name.orders' USING org.apache.hive.hcatalog.pig.HCatLoader();
                     b = load '$db_name.orders_new' USING org.apache.hive.hcatalog.pig.HCatLoader();
                     c = Join a by order_id full outer, b by order_id;
                     SPLIT c into d if b::order_id is null, e if b::order_id is not null;
                     d1 = foreach d generate $0,$1,$2,$3;
                     e1 = foreach e generate $4,$5,$6,$7;
                     f = UNION d1,e1;
                     STORE f INTO '$db_name.orders1' USING org.apache.hive.hcatalog.pig.HCatStorer(); 
"
##> /home/cloudera/Desktop/project1/cdc_problem.txt


##STORE f INTO '$db_name.orders' USING org.apache.hive.hcatalog.pig.HCatStorer();

