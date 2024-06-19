<?php
include_once '../config.php';
require_once '../../vendor/autoload.php';

use Dompdf\Dompdf;
use Dompdf\Options;

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $startDate = $_GET['startDate'];
    $endDate = $_GET['endDate'];

    $managerStatsQuery = "
        SELECT CONCAT(sellers.FirstName, ' ', sellers.LastName) AS Manager, SUM(orderdetails.Quantity) AS SoldProducts
        FROM orders
        JOIN sellers ON orders.SellerID = sellers.ID
        JOIN orderdetails ON orders.ID = orderdetails.OrderID
        WHERE orders.OrderDate BETWEEN ? AND ?
        GROUP BY sellers.ID
    ";

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
    $stmt1->bind_param('ss', $startDate, $endDate);
    $stmt1->execute();
    $result1 = $stmt1->get_result();
    $managerStats = $result1->fetch_all(MYSQLI_ASSOC);

    $stmt2 = $conn->prepare($typeStatsQuery);
    $stmt2->bind_param('ss', $startDate, $endDate);
    $stmt2->execute();
    $result2 = $stmt2->get_result();
    $typeStats = $result2->fetch_all(MYSQLI_ASSOC);

    $html = '<h1>Goods sold by managers</h1>';
    $html .= '<table border="1" cellspacing="0" cellpadding="5">
                <thead>
                    <tr>
                        <th>Manager</th>
                        <th>Number of goods sold</th>
                    </tr>
                </thead>
                <tbody>';
    foreach ($managerStats as $stat) {
        $html .= '<tr>
                    <td>' . $stat['Manager'] . '</td>
                    <td>' . $stat['SoldProducts'] . '</td>
                  </tr>';
    }
    $html .= '</tbody></table>';

    $html .= '<h1>Sold goods by type</h1>';
    $html .= '<table border="1" cellspacing="0" cellpadding="5">
                <thead>
                    <tr>
                        <th>Product type</th>
                        <th>Number of goods sold</th>
                    </tr>
                </thead>
                <tbody>';
    foreach ($typeStats as $stat) {
        $html .= '<tr>
                    <td>' . $stat['ProductType'] . '</td>
                    <td>' . $stat['SoldProducts'] . '</td>
                  </tr>';
    }
    $html .= '</tbody></table>';

    // Налаштування опцій Dompdf
    $options = new Options();
    $options->set('defaultFont', 'DejaVu Sans');
    $dompdf = new Dompdf($options);

    // Завантаження HTML-контенту з налаштованим шрифтом
    $dompdf->loadHtml('
        <html>
        <head>
            <style>
                @font-face {
                    font-family: "Roboto";
                    src: url("../frontend/fonts/Roboto-Black.ttf") format("truetype");
                }
                body {
                    font-family: "DejaVu Sans", sans-serif;
                }
            </style>
        </head>
        <body>' . $html . '</body>
        </html>
    ');

    $dompdf->setPaper('A4', 'landscape');
    $dompdf->render();
    $dompdf->stream("statistics.pdf", array("Attachment" => 1));

    $stmt1->close();
    $stmt2->close();
    $conn->close();
}
?>
