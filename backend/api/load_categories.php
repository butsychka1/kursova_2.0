<?php
include_once '../config.php';

$sql = "SELECT ID, Name FROM categories";
$result = $conn->query($sql);
$categories = [];

while ($row = $result->fetch_assoc()) {
    $categories[] = $row;
}

echo json_encode($categories);
$conn->close();
?>
