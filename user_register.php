<?php
include("conn.php");

if (isset($_POST["username"])) {
    $username = $_POST["username"];
    $email = $_POST["email"];
    $password = $_POST["password"];
    $usertype = $_POST["usertype"];

    $res = $conn->query("insert into user(username,email, password, usertype)values('{$username}','{$email}','{$password}','{$usertype}')");


    if ($res) {
        echo "the user has been registered ";
    } elseif ($username != $_POST["username"]) {
        echo "the user has not been registered";
    }
}
