<?php
include("conn.php");

if (isset($_POST)) {

    $response = array();


    $res = $conn->query("select * from customers");

    if ($res->rowCount() > 0) {

        $return_arr['customers'] = array();
        while ($row = $res->fetch()) {
            array_push($return_arr['customers'], array(
                'customer_id' => $row['customer_id'],
                'fullname' => $row['fullname']
            ));
        }
        echo json_encode($return_arr);
    } else {
        array_push($response, array('code' => "no", 'sms' => "samething went wrong"));
    }
    echo json_encode($response);
}
