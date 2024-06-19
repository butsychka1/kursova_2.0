-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Час створення: Чрв 19 2024 р., 19:14
-- Версія сервера: 8.0.36
-- Версія PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База даних: `store`
--

-- --------------------------------------------------------

--
-- Структура таблиці `categories`
--

CREATE TABLE `categories` (
  `ID` int NOT NULL,
  `Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп даних таблиці `categories`
--

INSERT INTO `categories` (`ID`, `Name`) VALUES
(1, 'Столи'),
(2, 'Стільці'),
(3, 'Дивани'),
(4, 'Ліжка'),
(5, 'Шафи'),
(6, 'Комоди'),
(7, 'Тумбочки'),
(8, 'Письмові столи'),
(9, 'Кухонні столи'),
(10, 'Обідні столи'),
(11, 'Барні стільці'),
(12, 'Крісла'),
(13, 'Книжкові шафи'),
(14, 'ТВ-стенди'),
(15, 'Дитячі меблі');

-- --------------------------------------------------------

--
-- Структура таблиці `orderdetails`
--

CREATE TABLE `orderdetails` (
  `ID` int NOT NULL,
  `OrderID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  `Quantity` int NOT NULL,
  `PriceAtOrder` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп даних таблиці `orderdetails`
--

INSERT INTO `orderdetails` (`ID`, `OrderID`, `ProductID`, `Quantity`, `PriceAtOrder`) VALUES
(1, 1, 1, 2, 2000.00),
(2, 2, 2, 4, 500.00),
(3, 3, 3, 1, 8000.00),
(4, 4, 4, 2, 7000.00),
(5, 5, 5, 1, 10000.00),
(6, 6, 6, 2, 3000.00),
(7, 7, 7, 1, 1500.00),
(8, 8, 8, 2, 2500.00),
(9, 9, 9, 1, 2200.00),
(10, 10, 10, 2, 3000.00),
(11, 11, 11, 1, 1000.00),
(12, 12, 12, 2, 4000.00),
(13, 13, 13, 1, 3500.00),
(14, 14, 14, 2, 2500.00),
(15, 15, 15, 1, 5000.00);

-- --------------------------------------------------------

--
-- Структура таблиці `orders`
--

CREATE TABLE `orders` (
  `ID` int NOT NULL,
  `UserID` int DEFAULT NULL,
  `OrderDate` date NOT NULL,
  `Status` enum('В обробці','Відправлено','Доставлено') NOT NULL,
  `SellerID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп даних таблиці `orders`
--

INSERT INTO `orders` (`ID`, `UserID`, `OrderDate`, `Status`, `SellerID`) VALUES
(1, 2, '2024-06-01', 'В обробці', 1),
(2, 2, '2024-06-02', 'Відправлено', 2),
(3, 3, '2024-06-03', 'Доставлено', 3),
(4, 4, '2024-06-04', 'В обробці', 4),
(5, 5, '2024-06-05', 'Відправлено', 5),
(6, 6, '2024-06-06', 'Доставлено', 6),
(7, 7, '2024-06-07', 'В обробці', 7),
(8, 8, '2024-06-08', 'Відправлено', 8),
(9, 9, '2024-06-09', 'Доставлено', 9),
(10, 10, '2024-06-10', 'В обробці', 10),
(11, 11, '2024-06-11', 'Відправлено', 11),
(12, 12, '2024-06-12', 'Доставлено', 12),
(13, 13, '2024-06-13', 'В обробці', 13),
(14, 14, '2024-06-14', 'Відправлено', 14),
(15, 15, '2024-06-15', 'Доставлено', 15);

-- --------------------------------------------------------

--
-- Структура таблиці `products`
--

CREATE TABLE `products` (
  `ID` int NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` text,
  `Price` decimal(10,2) NOT NULL,
  `Stock` int NOT NULL,
  `CategoryID` int DEFAULT NULL,
  `ImageURL` varchar(255) DEFAULT NULL,
  `Manufacturer` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп даних таблиці `products`
--

INSERT INTO `products` (`ID`, `Name`, `Description`, `Price`, `Stock`, `CategoryID`, `ImageURL`, `Manufacturer`) VALUES
(1, 'Стіл кухонний', 'Cтіл для кухні', 2000.00, 10, 1, 'url/to/image1', 'IKEA'),
(2, 'Стілець кухонний', 'Зручний стілець з м`яким сидінням', 500.00, 20, 2, 'url/to/image2', 'IKEA'),
(3, 'Диван кутовий', 'Комфортний диван для вітальні', 8000.00, 5, 3, 'url/to/image3', 'IKEA'),
(4, 'Ліжко двоспальне', 'Зручне ліжко з матрацом', 7000.00, 7, 4, 'url/to/image4', 'IKEA'),
(5, 'Шафа 4-х дверна', 'Велика шафа для одягу', 10000.00, 3, 5, 'url/to/image5', 'IKEA'),
(6, 'Комод дерев`яний', 'Зручний комод з чотирма шухлядами', 3000.00, 8, 6, 'url/to/image6', 'IKEA'),
(7, 'Тумбочка нічна', 'Невелика тумбочка для спальні', 1500.00, 15, 7, 'url/to/image7', 'IKEA'),
(8, 'Письмовий стіл', 'Стіл для роботи та навчання', 2500.00, 12, 8, 'url/to/image8', 'IKEA'),
(9, 'Кухонний стіл', 'Стіл для кухні', 2200.00, 10, 9, 'url/to/image9', 'IKEA'),
(10, 'Обідній стіл', 'Великий стіл для їдальні', 3000.00, 6, 10, 'url/to/image10', 'IKEA'),
(11, 'Барний стілець', 'Високий стілець для бару', 1000.00, 18, 11, 'url/to/image11', 'IKEA'),
(12, 'Крісло офісне', 'Зручне крісло для офісу', 4000.00, 9, 12, 'url/to/image12', 'IKEA'),
(13, 'Книжкова шафа', 'Шафа для зберігання книг', 3500.00, 7, 13, 'url/to/image13', 'IKEA'),
(14, 'ТВ-стенд', 'Стенд для телевізора', 2500.00, 12, 14, 'url/to/image14', 'IKEA'),
(15, 'Дитяче ліжко', 'Ліжко для дитини', 5000.00, 5, 15, 'url/to/image15', 'IKEA');

-- --------------------------------------------------------

--
-- Структура таблиці `sellers`
--

CREATE TABLE `sellers` (
  `ID` int NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп даних таблиці `sellers`
--

INSERT INTO `sellers` (`ID`, `FirstName`, `LastName`, `Email`, `PasswordHash`, `Phone`) VALUES
(1, 'Олександр', 'Олександров', 'olexander@example.com', 'hashed_password16', '+380123456781'),
(2, 'Тетяна', 'Тетянова', 'tetyana@example.com', 'hashed_password17', '+380123456782'),
(3, 'Василь', 'Васильов', 'vasyl@example.com', 'hashed_password18', '+380123456783'),
(4, 'Ганна', 'Ганнова', 'hanna@example.com', 'hashed_password19', '+380123456784'),
(5, 'Микола', 'Миколов', 'mykola@example.com', 'hashed_password20', '+380123456785'),
(6, 'Ольга', 'Ольгівна', 'olga@example.com', 'hashed_password21', '+380123456786'),
(7, 'Сергій', 'Сергійов', 'serhiy@example.com', 'hashed_password22', '+380123456787'),
(8, 'Ірина', 'Іринівна', 'iryna@example.com', 'hashed_password23', '+380123456788'),
(9, 'Юрій', 'Юрійов', 'yuriy@example.com', 'hashed_password24', '+380123456789'),
(10, 'Марина', 'Маринова', 'maryna@example.com', 'hashed_password25', '+380123456780'),
(11, 'Богдан', 'Богданов', 'bogdan@example.com', 'hashed_password26', '+3801234567811'),
(12, 'Аліна', 'Алінівна', 'alina@example.com', 'hashed_password27', '+3801234567812'),
(13, 'Роман', 'Романов', 'roman@example.com', 'hashed_password28', '+3801234567813'),
(14, 'Валентина', 'Валентинівна', 'valentyna@example.com', 'hashed_password29', '+3801234567814'),
(15, 'Михайло', 'Михайлов', 'mykhailo@example.com', 'hashed_password30', '+3801234567815');

-- --------------------------------------------------------

--
-- Структура таблиці `users`
--

CREATE TABLE `users` (
  `ID` int NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Role` enum('Admin','Client') NOT NULL,
  `Address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп даних таблиці `users`
--

INSERT INTO `users` (`ID`, `FirstName`, `LastName`, `Email`, `PasswordHash`, `Role`, `Address`) VALUES
(1, 'Іван', 'Іванов', 'ivan@example.com', 'hashed_password1', 'Admin', 'вулиця Іванівська 1'),
(2, 'Петро', 'Петров', 'petro@example.com', 'hashed_password2', 'Client', 'вулиця Петрівська 2'),
(3, 'Марія', 'Марченко', 'maria@example.com', 'hashed_password3', 'Client', 'вулиця Марченківська 3'),
(4, 'Олена', 'Оленова', 'olena@example.com', 'hashed_password4', 'Client', 'вулиця Оленівська 4'),
(5, 'Олег', 'Олегов', 'oleh@example.com', 'hashed_password5', 'Client', 'вулиця Олегівська 5'),
(6, 'Наталія', 'Наталенко', 'natalia@example.com', 'hashed_password6', 'Client', 'вулиця Наталенківська 6'),
(7, 'Андрій', 'Андріїв', 'andriy@example.com', 'hashed_password7', 'Client', 'вулиця Андріївська 7'),
(8, 'Юлія', 'Юлієва', 'yulia@example.com', 'hashed_password8', 'Client', 'вулиця Юліївська 8'),
(9, 'Максим', 'Максимов', 'maksym@example.com', 'hashed_password9', 'Client', 'вулиця Максимівська 9'),
(10, 'Віктор', 'Вікторов', 'victor@example.com', 'hashed_password10', 'Client', 'вулиця Вікторовська 10'),
(11, 'Катерина', 'Катеринина', 'kateryna@example.com', 'hashed_password11', 'Client', 'вулиця Катерининівська 11'),
(12, 'Дмитро', 'Дмитров', 'dmytro@example.com', 'hashed_password12', 'Client', 'вулиця Дмитрівська 12'),
(13, 'Людмила', 'Людмилина', 'lyudmyla@example.com', 'hashed_password13', 'Client', 'вулиця Людмилинівська 13'),
(14, 'Володимир', 'Володимиров', 'volodymyr@example.com', 'hashed_password14', 'Client', 'вулиця Володимировська 14'),
(15, 'Світлана', 'Світланівна', 'svitlana@example.com', 'hashed_password15', 'Client', 'вулиця Світланівська 15');

--
-- Індекси збережених таблиць
--

--
-- Індекси таблиці `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`ID`);

--
-- Індекси таблиці `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Індекси таблиці `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `SellerID` (`SellerID`);

--
-- Індекси таблиці `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Індекси таблиці `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Індекси таблиці `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT для збережених таблиць
--

--
-- AUTO_INCREMENT для таблиці `categories`
--
ALTER TABLE `categories`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблиці `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблиці `orders`
--
ALTER TABLE `orders`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблиці `products`
--
ALTER TABLE `products`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблиці `sellers`
--
ALTER TABLE `sellers`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблиці `users`
--
ALTER TABLE `users`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Обмеження зовнішнього ключа збережених таблиць
--

--
-- Обмеження зовнішнього ключа таблиці `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`ID`),
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ID`);

--
-- Обмеження зовнішнього ключа таблиці `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`ID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`SellerID`) REFERENCES `sellers` (`ID`);

--
-- Обмеження зовнішнього ключа таблиці `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
