<?php
include("conn.php");

if (isset($_GET)) {

    $response = array();


    $res = $conn->query("select name, start_time, end_time, schadule.date from schadule join exam using(exam_id);");

    if ($res->rowCount() > 0) {

        while ($row = $res->fetch()) {
            array_push($response, array(
                'code' => "yes", 'name' => $row['name'], 'start_time' => $row['start_time'],
                'end_time' => $row['end_time'],
             'date' => $row['date']
            ));
        }
    } else {
        array_push($response, array('code' => "no", 'sms' => "this teacher is not exist"));
    }
    echo json_encode($response);
}
