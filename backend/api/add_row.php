<?php
include_once '../config.php';

$table = $_POST['tableName'];
unset($_POST['tableName']);

$columns = implode(", ", array_keys($_POST));
$values = implode(", ", array_map(function($value) use ($conn) {
    return "'" . $conn->real_escape_string($value) . "'";
}, array_values($_POST)));

$sql = "INSERT INTO $table ($columns) VALUES ($values)";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["message" => "Record added successfully"]);
} else {
    echo json_encode(["error" => $conn->error]);
}

$conn->close();
?>
