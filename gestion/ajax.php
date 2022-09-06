<?php 

    session_start(); 	

    include "./../lib/php/db.class.php";
    include "./../lib/php/db.conf.php";
    
    $data = array();
    if(isset($_POST["id"])) {
        $id = $_POST["id"];
        $result = DB::query("DELETE from comments where id=%i", $id);
        $data = array('status' => "success"); 
    }
    if(isset($_POST["comment_id"])) {
      $id = $_POST["comment_id"];
      $status = $_POST["status"];
      $content = $_POST["content"];
      $today = date("Y-m-d H:m:s");
      $result = DB::query("UPDATE comments set `status`=%s, content=%s, updated_at=%s where id=%i", $status, $content, $today, $id);
      $data = array('status' => "success"); 
    }
    header('Content-Type: application/json');
    echo json_encode($data);
?>
