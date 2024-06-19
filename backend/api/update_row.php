<?php
include_once '../config.php';

$table = $_POST['tableName'];
$id = $_POST['id'];
unset($_POST['tableName']);
unset($_POST['id']);

$updateParts = [];
foreach ($_POST as $key => $value) {
    $updateParts[] = "$key = '" . $conn->real_escape_string($value) . "'";
}
$updateString = implode(", ", $updateParts);

$sql = "UPDATE $table SET $updateString WHERE ID = $id";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["message" => "Record updated successfully"]);
} else {
    echo json_encode(["error" => $conn->error]);
}

$conn->close();
?>
