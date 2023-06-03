<?php
include("conn.php");

if (isset($_POST["exam_id"])) {
    $exam_id = $_POST["exam_id"];
    $start_time = $_POST["start_time"];
    $end_time = $_POST["end_time"];

    $res = $conn->query("insert into schadule(exam_id, start_time,end_time)values('{$exam_id}','{$start_time}','{$end_time}')");


    if ($res) {
      echo  "new schudele has been registered ";
    } else {
        echo "please fill the blank space ";
    }
}
