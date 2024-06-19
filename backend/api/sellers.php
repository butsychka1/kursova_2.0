<?php
include_once '../config.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method == 'GET') {
    $sql = "SELECT * FROM Sellers";
    $result = $conn->query($sql);
    $sellers = [];

    while ($row = $result->fetch_assoc()) {
        $sellers[] = $row;
    }

    echo json_encode($sellers);
} elseif ($method == 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $firstName = $data['firstName'];
    $lastName = $data['lastName'];
    $email = $data['email'];
    $passwordHash = $data['passwordHash'];
    $phone = $data['phone'];

    $sql = "INSERT INTO Sellers (FirstName, LastName, Email, PasswordHash, Phone) VALUES ('$firstName', '$lastName', '$email', '$passwordHash', '$phone')";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Seller added successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
} elseif ($method == 'PUT') {
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data['id'];
    $firstName = $data['firstName'];
    $lastName = $data['lastName'];
    $email = $data['email'];
    $passwordHash = $data['passwordHash'];
    $phone = $data['phone'];

    $sql = "UPDATE Sellers SET FirstName = '$firstName', LastName = '$lastName', Email = '$email', PasswordHash = '$passwordHash', Phone = '$phone' WHERE ID = '$id'";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Seller updated successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
} elseif ($method == 'DELETE') {
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data['id'];

    $sql = "DELETE FROM Sellers WHERE ID = '$id'";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Seller deleted successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
}

$conn->close();
?>
