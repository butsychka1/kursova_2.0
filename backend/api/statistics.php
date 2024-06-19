<?php
include_once '../config.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $startDate = $_GET['startDate'];
    $endDate = $_GET['endDate'];

    // Запит для отримання статистики по кількості проданих товарів кожним менеджером
    $managerStatsQuery = "
        SELECT CONCAT(sellers.FirstName, ' ', sellers.LastName) AS Manager, SUM(orderdetails.Quantity) AS SoldProducts
        FROM orders
        JOIN sellers ON orders.SellerID = sellers.ID
        JOIN orderdetails ON orders.ID = orderdetails.OrderID
        WHERE orders.OrderDate BETWEEN ? AND ?
        GROUP BY sellers.ID
    ";

    // Запит для отримання статистики по кількості проданих товарів за типом
    $typeStatsQuery = "
        SELECT categories.Name AS ProductType, SUM(orderdetails.Quantity) AS SoldProducts
        FROM orderdetails
        JOIN products ON orderdetails.ProductID = products.ID
        JOIN categories ON products.CategoryID = categories.ID
        JOIN orders ON orderdetails.OrderID = orders.ID
        WHERE orders.OrderDate BETWEEN ? AND ?
        GROUP BY categories.ID
    ";

    $stmt1 = $conn->prepare($managerStatsQuery);
    if ($stmt1 === false) {
        die('Prepare error: ' . htmlspecialchars($conn->error));
    }
    $stmt1->bind_param('ss', $startDate, $endDate);
    $stmt1->execute();
    $result1 = $stmt1->get_result();
    $managerStats = $result1->fetch_all(MYSQLI_ASSOC);
    $stmt1->close();

    $stmt2 = $conn->prepare($typeStatsQuery);
    if ($stmt2 === false) {
        die('Prepare error: ' . htmlspecialchars($conn->error));
    }
    $stmt2->bind_param('ss', $startDate, $endDate);
    $stmt2->execute();
    $result2 = $stmt2->get_result();
    $typeStats = $result2->fetch_all(MYSQLI_ASSOC);
    $stmt2->close();

    echo json_encode([
        'managerStats' => $managerStats,
        'typeStats' => $typeStats,
    ]);

    $conn->close();
}
?>
