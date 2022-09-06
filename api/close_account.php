<?php 

    include "./../lib/php/db.class.php";
    include "./../lib/php/db.conf.php";
    session_start();
    $data = "";
    if(isset($_GET["email"])) {
        $email = $_GET["email"];
        DB::query("DELETE FROM favourites WHERE email=%s", $email );
        $user = DB::queryFirstRow("SELECT * FROM users WHERE email=%s", $email);
        $user_id = $user["id"];
        DB::query("DELETE FROM comments WHERE `user_id`=%s", $user_id);
        DB::query("DELETE FROM users WHERE email=%s", $email);
    }
    header('Content-Type: application/json');
    $response = array("status" => "success");
    echo json_encode($response);
?>
