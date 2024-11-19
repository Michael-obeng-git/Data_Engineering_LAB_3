Introduction
TechCorp, a rapidly growing tech company, relies on an outdated database system that stores all its data in a single, sprawling table.
This table contains details on products, customers, orders, and inventory, leading to data redundancy, slow queries, and difficulty maintaining data integrity.
To improve efficiency and scalability, TechCorp needs to redesign this system into a well-structured relational database.

Part 1: Analyzing TechCorp’s Existing Table
Objectives
By the end of this lab, you will be able to:

Analyze and normalize an unstructured table to reduce redundancy.
Design a relational schema from a single-table database.
Implement ACID-compliant transactions to maintain data integrity.
Apply concurrency control techniques to handle simultaneous transactions safely.

Tasks
Break down the data into separate tables that meet 3NF requirements.
Explain your design choices for primary and foreign keys in each normalized table.
Create an ERD (Entity-Relationship Diagram) to visualize the relationships of the new schema, ensuring primary and foreign keys are correctly defined and relationships are labeled.

Discussion
Discuss how normalization helps reduce redundancy and improve data integrity.
Consider potential trade-offs and when denormalization might be necessary.
Part 2: Transaction Management with ACID Properties
Design a Transaction Scenario
Imagine a customer placing an order in TechCorp’s online store. This order transaction should include:

Inserting a new record in the Orders table.
Adding each item from the order into the OrderDetails table.
Decreasing the quantity in stock for each item in the Products table.
Apply ACID Properties
Atomicity: The entire order process should be treated as one transaction (if any part fails, the entire transaction should fail).
Consistency: The database should be updated only if all steps in the transaction succeed, leaving it in a consistent state.
Isolation: Ensure the transaction operates independently from other transactions.
Durability: Once completed, the transaction should be saved permanently.
Write the Transaction Code (or Pseudocode)
Draft working SQL code that applies each ACID property to the order transaction.

Part 3: Preventing Concurrency Issues in a Multi-User Environment
TechCorp’s new online store has gone live, and customers are now placing orders simultaneously. One popular product, the "TechCorp Smart Speaker," has only 10 units left in stock. Two customers, Alex and Taylor, both try to order 5 units of the speaker at the same time.

Steps to Complete the Task
Set Up the Concurrency Scenario
Assume the following starting table setup for the Products table.
Assume two transactions are being processed at the same time for the same product:
Transaction 1 (Alex’s order): Decreases stock by 5 units.
Transaction 2 (Taylor’s order): Decreases stock by 5 units.
Implement Row-Level Locking to Prevent Conflicts
Choose a Locking Mechanism: Use a row-level lock on the Products table to prevent both transactions from updating the same row simultaneously.
Write a SQL Script for the Locking Process: Write code that:
Starts Transaction 1 for Alex.
Places a lock on the row for ProductID 101.
Decreases StockQuantity by 5 for ProductID 101.
Commits Transaction 1 and releases the lock.
Simulate Transaction 2 (Taylor’s order):
Transaction 2 will wait for Transaction 1 to complete and release the lock before it can proceed.
Once Transaction 1 is complete, Transaction 2 can begin, verify the remaining stock, decrease the stock by 5, and commit.

Part 4: Document Stores with MongoDB – Designing a Product Catalog
Activity 1: Set Up a MongoDB Database
Set Up MongoDB.
Create a Database named ProductCatalog.
Create a Collection named Products where each document represents a unique product.
Activity 2: Design Product Documents
Design documents to store different types of products, considering that each product type might have unique attributes. For example:
Electronics (e.g., ProductID, Name, Brand, Price, Specifications).
Clothing (e.g., ProductID, Name, Size, Color, Material, Price).
Books (e.g., ProductID, Title, Author, Genre, ISBN, Price).
Each document should contain only relevant attributes to its product type, showcasing MongoDB’s schema flexibility.

Activity 3: Insert Sample Documents
Use MongoDB queries to insert several sample product documents into the Products collection.

Part 5: Data Lakes and Lakehouses
Activity: Design a Data Lake Architecture for TechCorp’s Analytics Platform
Objective: Understand the components and benefits of data lakes and lakehouses.
Task: Create a high-level architecture diagram and outline the data ingestion, storage, and processing workflows.
