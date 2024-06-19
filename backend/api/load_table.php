<?php
include_once '../config.php';

$table = $_GET['table'];
$sql = "SELECT * FROM $table";
$result = $conn->query($sql);
$rows = [];

while ($row = $result->fetch_assoc()) {
    $rows[] = $row;
}

echo json_encode($rows);
$conn->close();
?>
