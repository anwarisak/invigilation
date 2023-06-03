<?php
include("conn.php");

if (isset($_GET)) {

    $response = array();


    $res = $conn->query("select fullname,date, amount from payment join customers using(customer_id) where paid_date > CURRENT_DATE;
    ");

    if ($res->rowCount() > 0) {

        while ($row = $res->fetch()) {
            array_push($response, array(
                'code' => "yes", 'fullname' => $row['fullname'], 'amount' => $row['amount']


            ));
        }
    } else {
        array_push($response, array('code' => "no", 'sms' => "this customer is not exist"));
    }
    echo json_encode($response);
}
