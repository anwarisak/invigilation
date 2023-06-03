<?php

$conn = new mysqli("localhost", "root", "", "invigilation");

if ($conn->connect_error) {
    echo $conn->error;
}
