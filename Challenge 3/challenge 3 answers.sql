use practice2 ;

show tables ; 


-- 1. What are the names of all the countries in the country table ?

select * from country ; 

select distinct(country_name) as "Country" from country ; 

-- 2. What is the total number of customers in the customers table ?

select count(customer_id) as "Total count of customers" from customers ; 

-- or

select count(distinct(customer_id)) as "Total count of customers" from customers ; 

-- What is the average age of customers who can receive marketing emails (can_email is set to 'yes') ?

select round(avg(age)) as "average age of customers who can receive marketing emails" from customers where can_email = 'yes' ;

-- How many orders were made by customers aged 30 or older?

select customer_id as "Customer ID", count(order_id) as "Total Orders" from  
              ( select ord.order_id , ord.customer_id , cus.age 
                from customers cus right join orders ord 
                on cus.customer_id = ord.customer_id ) table1
where age >= 30 group by customer_id ;

-- What is the total revenue generated by each product category?

with table1 as 
      ( select prd.category , prd.price 
        from orders ord left join baskets bsk on ord.order_id = bsk.order_id 
						right join products prd on bsk.product_id = prd.product_id )  
select category , sum(price) as "Revenue Generated" from table1 group by category ;     

-- What is the average price of products in the 'food' category?
                
select round( avg(price) , 2) as "average price of products in the 'food' category" from products where category = 'food' ;

-- How many orders were made in each sales channel (sales_channel column) in the orders table?

select sales_channel , count(*) as "Orders" from orders group by sales_channel ; 

-- What is the date of the latest order made by a customer who can receive marketing emails?

with table1 as (select cus.can_email , ord.date_shop
                from customers cus inner join orders ord 
				on cus.customer_id = ord.customer_id ) 
select max(date_shop) as "latest order date made by a customer who can receive marketing emails" 
from table1 where can_email = 'yes' ;


-- What is the name of the country with the highest number of orders?

select country_name as "Country Name with the Highest Order Count" , count(order_id) as "Orders Count" from
          ( select ord.order_id , cnt.country_name 
            from orders ord inner join country cnt 
            on ord.country_id= cnt.country_id ) table1
group by country_name order by count(order_id) desc limit 1; 


--  What is the average age of customers who made orders in the 'vitamins' product category ?

select round( avg(age) , 2 ) as "average age of customers who made orders in the 'vitamins' product category" 
	from     ( select cus.age , prd.category
	                            from customers cus inner join orders ord on cus.customer_id = ord.customer_id
						                           inner join baskets bsk on bsk.order_id = ord.order_id
						                           inner join products prd on prd.product_id = bsk.product_id
             ) table1
	where category = 'vitamins' ;
          
          
          






















































































 







