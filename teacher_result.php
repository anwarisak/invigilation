<?php
include("conn.php");

if (isset($_GET)) {

    $response = array();


    $res = $conn->query("select fullname, address,city,phone, hire_date from teacher");

    if ($res->rowCount() > 0) {

        while ($row = $res->fetch()) {
            array_push($response, array(
                'status' => "true", 'fullname' => $row['fullname'], 'address' => $row['address'],
                'city' => $row['city'],
                'phone' => $row['phone'], 'hire_date' => $row['hire_date']
            ));
        }
    } else {
        array_push($response, array('status' => "false", 'sms' => "this teacher is not exist"));
    }
    echo json_encode($response);
}
