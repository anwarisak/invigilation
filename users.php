<?php

include("conn.php");

if (isset($_GET["username"])) {
    $username = $_GET["username"];
    $password = $_GET["password"];

    $response = array();
    $res = $conn->query("select user_id, cs_status from user where username = '{$username}' and password = '{$password}'");

    if ($res->rowCount() > 0) {

        while ($row = $res->fetch()) {
            array_push($response, array(
                'code' => "yes", 'user_id' => $row['user_id'],
                'cs_status' => $row['cs_status']
            ));
        }
    } else {
        array_push($response, array('code' => "no", 'sms' => "username or password is incorrect"));
    }
    echo json_encode($response);
}
