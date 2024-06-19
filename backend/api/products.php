<?php
header('Content-Type: application/json');
include_once '../config.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method == 'GET') {
    $sql = "SELECT * FROM Products";
    $result = $conn->query($sql);
    $products = [];

    while ($row = $result->fetch_assoc()) {
        $products[] = $row;
    }

    echo json_encode($products);
} elseif ($method == 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $name = $data['name'];
    $description = $data['description'];
    $price = $data['price'];
    $stock = $data['stock'];
    $categoryID = $data['categoryID'];
    $imageURL = $data['imageURL'];
    $manufacturer = $data['manufacturer'];

    $sql = "INSERT INTO Products (Name, Description, Price, Stock, CategoryID, ImageURL, Manufacturer) VALUES ('$name', '$description', '$price', '$stock', '$categoryID', '$imageURL', '$manufacturer')";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Product added successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
} elseif ($method == 'PUT') {
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data['id'];
    $name = $data['name'];
    $description = $data['description'];
    $price = $data['price'];
    $stock = $data['stock'];
    $categoryID = $data['categoryID'];
    $imageURL = $data['imageURL'];
    $manufacturer = $data['manufacturer'];

    $sql = "UPDATE Products SET Name = '$name', Description = '$description', Price = '$price', Stock = '$stock', CategoryID = '$categoryID', ImageURL = '$imageURL', Manufacturer = '$manufacturer' WHERE ID = '$id'";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Product updated successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
} elseif ($method == 'DELETE') {
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data['id'];

    $sql = "DELETE FROM Products WHERE ID = '$id'";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Product deleted successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
}

$conn->close();
?>
