use sys;
-- drop table OrderDetails;
-- drop table Orders;
-- drop table Books;
-- drop table Customers;
-- drop table Authors;

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100),
    ISBN VARCHAR(25),
    Price DECIMAL(5,  2),
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    BookID INT,
    Quantity INT,
    Price DECIMAL(5,  2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


INSERT INTO Authors (FirstName, LastName) VALUES
('John', 'Doe'),
('Jane', 'Smith'),
('Alice', 'Johnson');

INSERT INTO Books (Title, ISBN, Price, AuthorID) VALUES
('The Great Adventure', '978-1234567890',  19.99,  1),
('Mysterious Journey', '978-0987654321',  24.99,  2),
('Tales of Wonder', '978-5678901234',  15.99,  3);

INSERT INTO Customers (FirstName, LastName, Email) VALUES
('Bob', 'Builder', 'bob@example.com'),
('Alice', 'Wonderland', 'alice@example.com'),
('Charlie', 'Brown', 'charlie@example.com');

INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2023-01-01'),
(2, '2023-01-15'),
(3, '2023-01-30');

INSERT INTO OrderDetails (OrderID, BookID, Quantity, Price) VALUES
(1,  1,  2,  19.99), -- Bob Builder ordered  2 copies of The Great Adventure
(1,  2,  1,  24.99), -- Bob Builder ordered  1 copy of Mysterious Journey
(2,  3,  3,  15.99), -- Alice Wonderland ordered  3 copies of Tales of Wonder
(3,  1,  1,  19.99), -- Charlie Brown ordered  1 copy of The Great Adventure
(3,  2,  2,  24.99); -- Charlie Brown ordered  2 copies of Mysterious Journey

SELECT B.Title, SUM(OD.Quantity) AS TotalSold
FROM Books B
JOIN OrderDetails OD ON B.BookID = OD.BookID
GROUP BY B.BookID
ORDER BY TotalSold DESC;

SELECT SUM(OD.Quantity * OD.Price) AS TotalRevenue
FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE O.OrderDate BETWEEN '2023-01-01' AND '2023-01-31';