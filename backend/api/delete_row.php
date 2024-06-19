<?php
include_once '../config.php';

$data = json_decode(file_get_contents('php://input'), true);
$id = $data['id'];
$table = $data['tableName'];

$sql = "DELETE FROM $table WHERE ID = $id";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["message" => "Record deleted successfully"]);
} else {
    echo json_encode(["error" => $conn->error]);
}

$conn->close();
?>
