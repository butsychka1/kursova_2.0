<?php
include_once '../config.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method == 'GET') {
    $sql = "SELECT * FROM Orders";
    $result = $conn->query($sql);
    $orders = [];

    while ($row = $result->fetch_assoc()) {
        $orders[] = $row;
    }

    echo json_encode($orders);
} elseif ($method == 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $userID = $data['userID'];
    $orderDate = $data['orderDate'];
    $status = $data['status'];
    $sellerID = $data['sellerID'];

    $sql = "INSERT INTO Orders (UserID, OrderDate, Status, SellerID) VALUES ('$userID', '$orderDate', '$status', '$sellerID')";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Order added successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
} elseif ($method == 'PUT') {
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data['id'];
    $userID = $data['userID'];
    $orderDate = $data['orderDate'];
    $status = $data['status'];
    $sellerID = $data['sellerID'];

    $sql = "UPDATE Orders SET UserID = '$userID', OrderDate = '$orderDate', Status = '$status', SellerID = '$sellerID' WHERE ID = '$id'";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Order updated successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
} elseif ($method == 'DELETE') {
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data['id'];

    $sql = "DELETE FROM Orders WHERE ID = '$id'";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Order deleted successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
}

$conn->close();
?>
