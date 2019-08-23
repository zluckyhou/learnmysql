SET PASSWORD
FOR 'root'@'localhost' = PASSWORD('9870384');

 --导入utc画像，包括日期、媒体

CREATE TABLE profile_bymedia (created_at date,media varchar(255), tag_name varchar(255), tag_value varchar(255), cnt int(11)) DEFAULT charset=utf8;

 LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/profile_bymedia.tsv' INTO TABLE profile_bymedia character
SET utf8 fields terminated BY '\t' lines terminated BY '\n';

 --导入utc画像，包括日期、媒体、百分比

CREATE TABLE profile_bymedia (created_at date,media varchar(255), tag_name varchar(255), tag_value varchar(255), cnt int(11),pct float(5,4)) DEFAULT charset=utf8;

 LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/profile_bymedia.tsv.csv' INTO TABLE profile_bymedia character
SET utf8 fields terminated BY ',' lines terminated BY '\n'
IGNORE 1 ROWS;

 -- 导入user_profile最新统计结果

CREATE TABLE profile_stats (tag_name varchar(255), tag_value varchar(255), id_type int, cnt int) DEFAULT charset=utf8;

 LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/profile_stats_nopoi.csv' INTO TABLE profile_stats character
SET utf8 fields terminated BY '\t' lines terminated BY '\n'
IGNORE 1 ROWS;

--导入user_profile最新统计结果，包括日期
CREATE TABLE profile_stats (created_at date, tag_name varchar(255), tag_value varchar(255), id_type int, cnt int) DEFAULT charset=utf8;

 LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/profile_stats' INTO TABLE profile_stats character
SET utf8 fields terminated BY '\t' lines terminated BY '\n'
IGNORE 1 ROWS;

 -- 导入麦当劳订单流水,抽取其中的一些字段
 CREATE TABLE order_offline (us_code varchar(255), ts bigint, station_id varchar(255), fm_id varchar(255), platform varchar(255), amount float, status int, open_id varchar(255)) DEFAULT charset=utf8;

  LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/order_offline' INTO TABLE order_offline character
SET utf8 fields terminated BY '|' lines terminated BY '\n'
IGNORE 1 ROWS;

-- 导入小程序用户样例数据，抽取其中一些字段
CREATE TABLE customer (id varchar(255),phone bigint,member_id varchar(255),open_id varchar(255),union_id varchar(255),sex varchar(255),create_time int ,dt date) DEFAULT charset=utf8;

 LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/mcd_user_res' INTO TABLE customer character
SET utf8 fields terminated BY '\t' lines terminated BY '\n';

-- 在order_offline中新增一列日期格式的日期
alter table order_offline add column dt date ;
update order_offline a set a.dt=from_unixtime(a.ts,'%Y-%m-%d');

-- 删除order_offline中的station_id字段
alter table order_offline drop column station_id;

-- 随机选择20行
select * from order_offline order by rand() limit 20;

-- 随机删除100
delete from order_offline order by rand() limit 100;

-- 修改order_offline 表名为order
--alter table order_offline rename order;

-- 更新order_offline中的日期
update order_offline set dt='2018-05-13' where dt='2018-04-21';



SET SESSION sql_mode=NO_ZERO_IN_DATE;-- 非严格模式
CREATE TABLE members (union_id varchar(255), member_id varchar(255), rank varchar(255), phone varchar(255), gender varchar(255), birthday datetime DEFAULT NULL, points int, balance double, consume_freq double, consume_amount double, recharge_amount double, SOURCE varchar(255), join_time datetime DEFAULT NULL, first_consume_time datetime DEFAULT NULL, first_consume_store varchar(255), last_consume_time datetime DEFAULT NULL, last_consume_store varchar(255)) DEFAULT charset=utf8;

 LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/members.csv' INTO TABLE members character
SET utf8 fields terminated BY '~' lines terminated BY '\n'
IGNORE 1 ROWS;

CREATE TABLE orders (order_time datetime, order_id varchar(255), plate int, product varchar(255), pay_type varchar(255), status varchar(255), amount double, paid_amount double, minus_off double, coupon int, discount double, give double, invoice_status varchar(255), user_privilege varchar(255), service_type varchar(255), ori_order_id varchar(255), store varchar(255), member_id varchar(255), order_by varchar(255), memo varchar(255)) DEFAULT charset=utf8;
 LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/orders.csv' INTO TABLE orders character
SET utf8 fields terminated BY '~' lines terminated BY '\n'
IGNORE 1 ROWS;

CREATE TABLE sales (create_at datetime, union_id varchar(255), member_id varchar(255), transaction_no varchar(255), receipt_no varchar(255), order_id varchar(255), item_no varchar(255), item_name varchar(255), discount double, quantity int, amount double) DEFAULT charset=utf8;

 LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/sales.csv' INTO TABLE sales character
SET utf8 fields terminated BY '~' lines terminated BY '\n'
IGNORE 1 ROWS;


CREATE TABLE members_old ( member_id varchar(255), offline_id varchar(255), name varchar(255), phone bigint, birthday datetime, gender varchar(255), join_time datetime, union_id varchar(255), current_point int) DEFAULT charset=utf8;

 LOAD DATA infile '/Users/admin/workspace/ML/learnmysql/peets members_old system.csv' INTO TABLE members_old character
SET utf8 fields terminated BY ',' lines terminated BY '\n'
IGNORE 1 ROWS;
