<?php
include("conn.php");

if (isset($_POST["teacher_id"])) {
    $teacher_id = $_POST["teacher_id"];
    $room_id = $_POST["room_id"];

    $res = $conn->query("insert into assign_room(teacher_id, room_id)values('{$teacher_id}','{$room_id}')");


    if ($res) {
        echo "the assign_room has been registered ";
    } else {
        echo "please fill the blank space ";
    }
}
