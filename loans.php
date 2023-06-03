<?php
include("conn.php");

if (isset($_POST)) {

    $response = array();


    $res = $conn->query("select loan_id, customer_id from loan where customer_id=(select customer_id from customers where fullname='" . $_GET['fullname'] .  "')");

    if ($res->rowCount() > 0) {

        while ($row = $res->fetch()) {
            array_push($response, array(
                'code' => "yes", 'loan_id' => $row['loan_id'], 'fullname' => $row['fullname']
            ));
        }
    } else {
        array_push($response, array('code' => "no", 'sms' => "samething went wrong"));
    }
    echo json_encode($response);
}
