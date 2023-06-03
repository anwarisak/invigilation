<?php
include("conn.php");

if (isset($_POST["room_number"])) {
    $room_number = $_POST["room_number"];
    $capacity = $_POST["capacity"];

    $res = $conn->query("insert into rooms(room_number,capacity)values('{$room_number}','{$capacity}')");


    if ($res) {
        echo "the room has been registered ";
    } elseif ($room_number != $_POST["room_number"]) {
        echo "the user has not been registered";
    }
}
