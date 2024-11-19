use TechCorps;

-- Transaction 1 (Alex's order) 
start transaction;

select * from products where productID = 101 for update;

update products
set quantity = quantity - 5
where productID = 101;

commit;


-- Transaction 2 (Taylor's order) 
start transaction;

-- placing a lock on the row for productid 101
select * from products where productID = 101 for update;

-- Decrease quantity by 5 for productID 101
update products
set quantity = quantity - 5
where productID = 101;

commit;