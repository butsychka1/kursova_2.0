<?php
include_once '../config.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $productId = $_GET['id'];

    $query = "
        SELECT 
            products.Name AS ProductName, 
            CONCAT(users.FirstName, ' ', users.LastName) AS CustomerName, 
            CONCAT(sellers.FirstName, ' ', sellers.LastName) AS SellerName, 
            orders.OrderDate, 
            orders.Status AS OrderStatus, 
            orderdetails.PriceAtOrder AS Price
        FROM 
            orderdetails
        JOIN products ON orderdetails.ProductID = products.ID
        JOIN orders ON orderdetails.OrderID = orders.ID
        JOIN users ON orders.UserID = users.ID
        JOIN sellers ON orders.SellerID = sellers.ID
        WHERE products.ID = ?
    ";

    $stmt = $conn->prepare($query);
    $stmt->bind_param('i', $productId);
    $stmt->execute();
    $result = $stmt->get_result();
    $details = $result->fetch_assoc();

    echo json_encode($details);

    $stmt->close();
    $conn->close();
}
?>
