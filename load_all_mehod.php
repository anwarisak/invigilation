<?php
require_once("connection.php");

$sql = "select * from payment_method";
if (!$conn->query($sql)) {
    echo "error in connecting database.";
} else {
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $return_arr['payment_method'] = array();
        while ($row = $result->fetch_array()) {
            array_push($return_arr['payment_method'], array(
                'payment_method_id' => $row['payment_method_id'],
                'name' => $row['name'],

            ));
        }
        echo json_encode($return_arr);
    }
}
