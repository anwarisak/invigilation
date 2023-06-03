<?php
require_once("connection.php");

$sql = "select * from account";
if (!$conn->query($sql)) {
    echo "error in connecting database.";
} else {
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $return_arr['account'] = array();
        while ($row = $result->fetch_array()) {
            array_push($return_arr['account'], array(
                'account_id' => $row['account_id'],
                'bank_name' => $row['bank_name'],

            ));
        }
        echo json_encode($return_arr);
    }
}
