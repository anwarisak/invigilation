<?php
include("conn.php");

if (isset($_POST["fullname"])) {
    $fullname = $_POST["fullname"];
    $address = $_POST["address"];
    $city = $_POST["city"];
    $phone = $_POST["phone"];

    $res = $conn->query("insert into teacher(fullname,address, city, phone)values('{$fullname}','{$address}','{$city}','{$phone}')");


    if ($res) {
        echo "the teacher has been registered ";
    } else {
        echo "please fill the blank space ";
    }
}
