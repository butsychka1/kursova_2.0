<?php
include_once '../config.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method == 'GET') {
    $sql = "SELECT * FROM Users";
    $result = $conn->query($sql);
    $users = [];

    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }

    echo json_encode($users);
} elseif ($method == 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $firstName = $data['firstName'];
    $lastName = $data['lastName'];
    $email = $data['email'];
    $passwordHash = $data['passwordHash'];
    $role = $data['role'];
    $address = $data['address'];

    $sql = "INSERT INTO Users (FirstName, LastName, Email, PasswordHash, Role, Address) VALUES ('$firstName', '$lastName', '$email', '$passwordHash', '$role', '$address')";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "User added successfully"]);
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
    $role = $data['role'];
    $address = $data['address'];

    $sql = "UPDATE Users SET FirstName = '$firstName', LastName = '$lastName', Email = '$email', PasswordHash = '$passwordHash', Role = '$role', Address = '$address' WHERE ID = '$id'";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "User updated successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
} elseif ($method == 'DELETE') {
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data['id'];

    $sql = "DELETE FROM Users WHERE ID = '$id'";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "User deleted successfully"]);
    } else {
        echo json_encode(["error" => $conn->error]);
    }
}

$conn->close();
?>
