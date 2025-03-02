-- TASK A
-- MAKE DATA BASE 
use master;

CREATE DATABASE Social_Media_Platform 

use Social_Media_Platform 
go
CREATE TABLE Users (
    userID INT IDENTITY(1,1) PRIMARY KEY,
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female')),
    Email NVARCHAR(255) UNIQUE NOT NULL,
    userName NVARCHAR(100) NOT NULL,
    joinDate DATETIME DEFAULT GETDATE(),
    DoB DATE
);

CREATE TABLE Post (
    postID INT IDENTITY(1,1) PRIMARY KEY,
    content NVARCHAR(MAX) NOT NULL,
    postDate DATETIME DEFAULT GETDATE(),
    visibility NVARCHAR(10) CHECK (visibility IN ('Public', 'Private', 'Friends')),
    userID INT,
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE
);

CREATE TABLE Comment (
    commentID INT IDENTITY(1,1) PRIMARY KEY,
    userID INT,
    postID INT,
    commentDate DATETIME DEFAULT GETDATE(),
    content NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (userID) REFERENCES Users(userID)  ,
    FOREIGN KEY (postID) REFERENCES Post(postID) 
);

CREATE TABLE Interaction (
    interactionID INT IDENTITY(1,1) PRIMARY KEY,
    userID INT,
    postID INT,
    type NVARCHAR(10) CHECK (type IN ('Like', 'Love', 'Haha', 'Sad', 'Angry')),
    interactionDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (userID) REFERENCES Users(userID) ,
    FOREIGN KEY (postID) REFERENCES Post(postID)
);

CREATE TABLE UserInteractPost (
    userID INT,
    postID INT,
    PRIMARY KEY (userID, postID),
    FOREIGN KEY (userID) REFERENCES Users(userID),
    FOREIGN KEY (postID) REFERENCES Post(postID) 
);
 

 -- MAKE INSERT IN DATABASE


 INSERT INTO Users (Gender, Email, userName, joinDate, DoB) VALUES
('Male', 'john.doe@example.com', 'JohnDoe', GETDATE(), '1995-06-15'),
('Female', 'jane.smith@example.com', 'JaneSmith', GETDATE(), '1998-09-23');


INSERT INTO Post (content, postDate, visibility, userID) VALUES
('This is my first post!', GETDATE(), 'Public', 1),
('Loving the new features of this platform!', GETDATE(), 'Friends', 2);

INSERT INTO Comment (userID, postID, commentDate, content) VALUES
(2, 1, GETDATE(), 'Great post!'),
(1, 2, GETDATE(), 'Nice thoughts, Jane!');

INSERT INTO Interaction (userID, postID, type, interactionDate) VALUES
(1, 2, 'Like', GETDATE()),
(2, 1, 'Love', GETDATE());

INSERT INTO UserInteractPost (userID, postID) VALUES
(1, 1),
(2, 2);




--TASK B


USE master
GO

CREATE DATABASE OrdersDB;
GO
USE OrdersDB;
GO


CREATE TABLE Customer (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20) NOT NULL,
    Address NVARCHAR(255) NOT NULL
);

CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    Category NVARCHAR(100) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    TotalAmount DECIMAL(10,2) NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) CHECK (Status IN ('Pending', 'Completed', 'Cancelled')),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(ID) ON DELETE CASCADE
);

CREATE TABLE OrderDetails (
    OrderDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
);

CREATE TABLE ProductOrder (
    ProductID INT,
    OrderID INT,
    PRIMARY KEY (ProductID, OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID) ON DELETE CASCADE
);


CREATE TABLE Supplier (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    ContactInfo NVARCHAR(255) NOT NULL
);


CREATE TABLE ProductSupplier (
    ProductID INT,
    SupplierID INT,
    PRIMARY KEY (ProductID, SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) ON DELETE CASCADE
);




-- MAKE INSERT


INSERT INTO Customer (Email, Name, PhoneNumber, Address) VALUES
('john.doe@example.com', 'John Doe', '1234567890', '123 Main St, City A'),
('jane.smith@example.com', 'Jane Smith', '0987654321', '456 Elm St, City B');

INSERT INTO Product (Category, Name, Description, Price) VALUES
('Electronics', 'Laptop', 'A high-performance laptop', 1200.99),
('Home Appliances', 'Vacuum Cleaner', 'Powerful vacuum cleaner', 299.99);

INSERT INTO [Order] (TotalAmount, Status, CustomerID) VALUES
(1500.50, 'Completed', 1),
(350.75, 'Pending', 2);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1200.99),
(2, 2, 1, 299.99);

INSERT INTO ProductOrder (ProductID, OrderID) VALUES
(1, 1),
(2, 2);

INSERT INTO Supplier (Name, ContactInfo) VALUES
('Tech Supplier Inc.', 'contact@techsupplier.com'),
('Home Essentials Ltd.', 'info@homeessentials.com');

INSERT INTO ProductSupplier (ProductID, SupplierID) VALUES
(1, 1),
(2, 2);



-- DDL



--1

ALTER TABLE Product
ADD rating INT DEFAULT 0 CHECK (rating BETWEEN 0 AND 10) ;

--2

ALTER TABLE Product
ADD CONSTRAINT DF_Product_Category DEFAULT 'new' FOR Category;

--3
ALTER TABLE Product
DROP COLUMN Rating;

--ALTER TABLE Product 
--DROP CONSTRAINT CK__Product__rating__4E88ABD4;


--4

use Social_Media_Platform

drop table Users

--SELECT 
--    OBJECT_NAME(parent_object_id) AS TableName, 
--    name AS ConstraintName, 
--    type_desc AS ConstraintType
--FROM sys.objects 
--WHERE parent_object_id = OBJECT_ID('Users') 
--AND type IN ('C', 'F', 'PK', 'UQ', 'D');







--  DML
--1

UPDATE O
SET O.OrderDate = GETDATE()
FROM [Order] O
WHERE O.OrderID > 0;


--2

delete O
SET O. = GETDATE()
FROM [Order] O
WHERE O.OrderID > 0;