<?php
include("conn.php");

if (isset($_POST["name"])) {
    $name = $_POST["name"];

    $res = $conn->query("insert into exam(name)values('{$name}')");


    if ($res) {
        echo "the exam has been registered ";
    } else {
        echo "please fill the blank space ";
    }
}
