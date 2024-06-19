-- Створення таблиці Categories
CREATE TABLE Categories (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL
);

-- Створення таблиці Products
CREATE TABLE Products (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    CategoryID INT,
    ImageURL VARCHAR(255),
    Manufacturer VARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES Categories(ID)
);

-- Створення таблиці Users
CREATE TABLE Users (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role ENUM('Admin', 'Client') NOT NULL,
    Address VARCHAR(255)
);

-- Створення таблиці Sellers
CREATE TABLE Sellers (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Phone VARCHAR(20)
);

-- Створення таблиці Orders
CREATE TABLE Orders (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    OrderDate DATE NOT NULL,
    Status ENUM('В обробці', 'Відправлено', 'Доставлено') NOT NULL,
    SellerID INT,
    FOREIGN KEY (UserID) REFERENCES Users(ID),
    FOREIGN KEY (SellerID) REFERENCES Sellers(ID)
);

-- Створення таблиці OrderDetails
CREATE TABLE OrderDetails (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    PriceAtOrder DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(ID),
    FOREIGN KEY (ProductID) REFERENCES Products(ID)
);
