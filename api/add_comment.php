<?php 

    session_start(); 	
    if($_GET["language"]) { 
        $_SESSION["langue"] = $_GET["language"];
    } 
    $i = 1;
    $langue = $_SESSION["langue"];
    if (!isset($langue)) {
        $langue=1;
    }

    include "./../langues/".$langue.".php";
    include "./../lib/php/db.class.php";
    include "./../lib/php/db.conf.php";
    
    $data = array();
    if(isset($_GET["storyNo"])) {
        $dialog_id = $_GET["storyNo"];
        $email = $_GET["email"];
        $content = $_GET["comment"];
        $language_id = $_GET["language"];
        $user = DB::queryFirstRow("SELECT * FROM users WHERE email=%s", $email);
        $today = date("Y-m-d H:m:s");
        $result = DB::query("INSERT INTO comments (`user_id`, dialog_id, content, `status`, language_id, updated_at) VALUES (%i, %i, %s, %i, %i, %s)", $user["id"], $dialog_id, $content, 0, $language_id, $today);
        
        $data = array('status' => "success"); 
    }

    header('Content-Type: application/json');
    echo json_encode($data);
?>
