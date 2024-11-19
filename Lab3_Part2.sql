use TechCorps;


select * from orders;
select * from customers;


-- Transaction Management with ACID Properties
DELIMITER //

CREATE PROCEDURE PlaceOrder(
    IN NEW_ORDER_ID INT, 
    IN CUSTOMER_ID INT, 
    IN TOTAL_AMOUNT DECIMAL(10,2)
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_product_id INT;
    DECLARE current_quantity INT;

    -- Declare cursor for fetching order items from a temporary table
    DECLARE order_cursor CURSOR FOR SELECT ProductID, Quantity FROM TempOrderItems;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Start transaction
    START TRANSACTION;

    -- Step 1: Insert a new order record
    INSERT INTO orders (OrderID, CustomerID, OrderDate, Total)
    VALUES (NEW_ORDER_ID, CUSTOMER_ID, NOW(), TOTAL_AMOUNT);

    OPEN order_cursor;

    read_loop: LOOP
        FETCH order_cursor INTO current_product_id, current_quantity;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Step 2: Add each item to the OrderDetails table
        INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
        VALUES (NEW_ORDER_ID, current_product_id, current_quantity, 
                (SELECT Price FROM products WHERE ProductID = current_product_id));

        -- Step 3: Decrease the quantity in stock for each product
        UPDATE products
        SET StockQuantity = StockQuantity - current_quantity
        WHERE ProductID = current_product_id;

        -- Check if the stock is sufficient
        IF (SELECT StockQuantity FROM products WHERE ProductID = current_product_id) < 0 THEN
            ROLLBACK;  -- Roll back the transaction if stock is insufficient
            SELECT 'Transaction failed: Insufficient stock for ProductID ' AS ErrorMessage;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE order_cursor;

    -- Commit the transaction if all steps succeed
    COMMIT;
END //

DELIMITER ;