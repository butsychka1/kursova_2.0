<?php
$servername = "localhost";
$username = "root"; // Змініть на вашого користувача MySQL
$password = "root"; // Змініть на ваш пароль MySQL
$dbname = "store"; // Назва вашої бази даних

// Створення з'єднання
$conn = new mysqli($servername, $username, $password, $dbname);

// Перевірка з'єднання
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
