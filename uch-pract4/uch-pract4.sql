CREATE DATABASE ShopDB;
GO

USE ShopDB;
GO

CREATE TABLE Products (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Category NVARCHAR(50)
);
GO

-- Добавим тестовые данные
INSERT INTO Products (ProductName, Price, Category) VALUES 
('Ноутбук Dell', 45000.00, 'Electronics'),
('Смартфон Samsung', 32000.00, 'Electronics'),
('Кофемашина', 15000.00, 'Appliances'),
('Офисное кресло', 8500.00, 'Furniture');
GO