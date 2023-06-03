<?php
require_once("connection.php");

$sql = "select * from exam";
if (!$conn->query($sql)) {
    echo "error in connecting database.";
} else {
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $return_arr['exam'] = array();
        while ($row = $result->fetch_array()) {
            array_push($return_arr['exam'], array(
                'exam_id' => $row['exam_id'],
                'name' => $row['name'],

            ));
        }
        echo json_encode($return_arr);
    }
}
