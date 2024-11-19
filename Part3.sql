-- use TechCorps;
  
  
-- CONCURRENCY CONTROL
-- Creation of startup table

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    StockQuantity INT
);

-- insertion of samplle Data into table
INSERT INTO Product (ProductID, ProductName, StockQuantity)
VALUES (101, 'TechCorp Smart Speaker', 10);


-- Implementation of Row-level Locking to Prevent Conflicts


-- Transaction 1: Alex's Order
START TRANSACTION;

-- Place a lock on the row for ProductID 101
SELECT StockQuantity FROM Product WHERE ProductID = 101 FOR UPDATE;

-- Decrease StockQuantity by 5 for ProductID 101
UPDATE Product
SET StockQuantity = StockQuantity +5
WHERE ProductID = 101;

-- Commit Transaction 1 and release the lock
COMMIT;


-- Transaction 2: Taylor's Order
START TRANSACTION;

-- Attempt to lock the row for ProductID 101
SELECT StockQuantity FROM Product WHERE ProductID = 101 FOR UPDATE;

-- Check the remaining stock after acquiring the lock
SET @stock := (SELECT StockQuantity FROM Product WHERE ProductID = 101);

select @stock, if(StockQuantity >= 5,
    -- Decrease StockQuantity by 5 for ProductID 101
    -- UPDATE Product
     StockQuantity = StockQuantity - 5
    , rollback( "Insufficient stock")
    ) 
    
    from product
    where StockQuantity >= 5;

    -- Commit Transaction 2
    COMMIT;
    
-- ELSE
--     -- Handle the case where there is not enough stock
--     ROLLBACK;
--     SELECT 'Not enough stock available for Taylor''s order' AS Message;
-- END IF;