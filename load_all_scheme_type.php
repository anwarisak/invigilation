<?php
require_once("connection.php");

$sql = "select * from scheme_type";
if (!$conn->query($sql)) {
    echo "error in connecting database.";
} else {
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $return_arr['scheme_type'] = array();
        while ($row = $result->fetch_array()) {
            array_push($return_arr['scheme_type'], array(
                'scheme_type_id' => $row['scheme_type_id'],
                'name' => $row['name'],

            ));
        }
        echo json_encode($return_arr);
    }
}
