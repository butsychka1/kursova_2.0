<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Включення файлу конфігурації
include_once 'config.php';

// Маршрутизація запитів
$request = $_SERVER['REQUEST_URI'];

switch ($request) {
    case '/api/products' :
        include('api/products.php');
        break;
    case '/api/users' :
        include('api/users.php');
        break;
    case '/api/orders' :
        include('api/orders.php');
        break;
    case '/api/sellers' :
        include('api/sellers.php');
        break;
    case '/api/statistics' :
        include('api/statistics.php');
        break;
    case '/api/documents' :
        include('api/documents.php');
        break;
    default:
        http_response_code(404);
        echo json_encode(["message" => "Page not found"]);
        break;
}
?>
