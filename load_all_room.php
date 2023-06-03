<?php
require_once("connection.php");

$sql = "select * from rooms";
if (!$conn->query($sql)) {
    echo "error in connecting database.";
} else {
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $return_arr['rooms'] = array();
        while ($row = $result->fetch_array()) {
            array_push($return_arr['rooms'], array(
                'room_id' => $row['room_id'],
                'room_number' => $row['room_number'],

            ));
        }
        echo json_encode($return_arr);
    }
}
