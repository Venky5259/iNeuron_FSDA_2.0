


Use DEMO_DATABASE01;


--- Created table BV_SALES_DATA with order_id as primary key

CREATE OR REPLACE TABLE BV_SALES_DATA (
  order_id CHAR(100) NOT NULL PRIMARY KEY,
  order_date DATE,
  ship_date DATE,
  ship_mode VARCHAR(100),
  customer_name VARCHAR(100),
  segment VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100),
  market VARCHAR(50),
  region VARCHAR(50) ,
  product_id CHAR(100),
  category VARCHAR(100),
  sub_category VARCHAR(100),
  product_name CHAR(200),
  sales NUMBER(20,0),
  quantity NUMBER(6,0),
  discount NUMBER(6,2),
  profit NUMBER(10,3),
  shipping_cost NUMBER(10,3),
  order_priority VARCHAR(50),
  year NUMBER(4,0)
);


describe table BV_SALES_DATA;

Select * from BV_SALES_DATA;




--- Extract the number after the last ‘–‘from Order ID column & adding it to new cloumn order_extract .

Select split_part(order_id,'-',-1) as order_extract, *
 from BV_SALES_DATA;



--- New column Discount_flag is created where discount greater then zero is Yes & less then zero is No.

Select *, 
  case
     when discount > 0 then 'YES'
     else 'NO'
     end as Discount_flag
   from BV_SALES_DATA;



--- New column process days is created to know period between order data & shipment date

Select * ,
      datediff('day',ORDER_DATE,SHIP_DATE) as Process_days
       from BV_SALES_DATA;




---- Created new column Rating where rating is based on processing days it took from order date to shipping date.

Select * , 
   datediff('day',ORDER_DATE,SHIP_DATE) as Process_days,
        case 
            when Process_days <= 3 then 5
            when Process_days > 3 and Process_days <= 6 then 4
            when Process_days > 6 and Process_days <= 10 then 3
            else 2 
            end as Ratings
        from  BV_SALES_DATA;    