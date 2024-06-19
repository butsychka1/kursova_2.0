<?php
include_once '../config.php';

$id = $_GET['id'];
$table = $_GET['table'];

$sql = "SELECT * FROM $table WHERE ID = $id";
$result = $conn->query($sql);
$row = $result->fetch_assoc();

echo json_encode($row);
$conn->close();
?>
