use TechCorps;


select * from orders;
select * from customers;


-- Transaction Management with ACID Properties
-- ATOMICITY
select * from orders;

-- Inserting a new record in the Orders table
start transaction;
insert into orders(orderID,customerID,productID,orderdate,quantity,total)
values(5,1,101,'2024-11-01',2,60);

-- Adding each item from the order into the OrderDetails table.
insert into orderDetails(orderID,productID,quantity,price)
values (5,101,2,
(select price from orders where orderID = 5)
);

-- Maintaining database consistency before and after the transaction by updating product table.
 -- Decreasing the quantity in stock for each item in the Products table
update products
set StockQuantity = StockQuantity - (select quantity from orderDetails where orderID = 5) 
where productID = 101;
 
rollback;
-- Commit the transaction if all steps succeed
commit;

select* from orders;
select * from orderDetails;


-- Ensuring that transactions are executed in isolation from one another.
set transaction isolation level serializable;
start transaction;
select * from orders where orderID = 5;
