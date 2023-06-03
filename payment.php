<?php
include("conn.php");

if (isset($_POST["teacher_id"])) {
    $teacher_id = $_POST["teacher_id"];
    $account_id = $_POST["account_id"];
    $amount = $_POST["amount"];
    $payment_method_id = $_POST["payment_method_id"];

    $res = $conn->query("insert into payment(teacher_id, account_id, amount, payment_method_id)values('{$teacher_id}','{$account_id}','{$amount}','{$payment_method_id}')");


    if ($res) {
        echo "the payment has been registered ";
    } else {
        echo "please fill the blank space ";
    }
}
