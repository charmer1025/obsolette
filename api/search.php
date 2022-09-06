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
    $histoire = DB::queryFirstRow("SELECT * FROM dialogues WHERE langueId=%i  AND cible<1 ORDER BY id DESC", $langue);
    $story = $histoire["titre"];
    $storyid= $histoire["id"];
    array_push($data, ["story" => $story, "id" => $storyid]);    

    $histoire = DB::queryFirstRow("SELECT * FROM dialogues WHERE langueId=%i AND auteur<>''  AND cible<1 ORDER BY id DESC", $langue);
    $story = $histoire["titre"];
    $storyid= $histoire["id"];
    array_push($data, ["story" => $story, "id" => $storyid]);    

    $histoire = DB::queryFirstRow("SELECT * FROM dialogues WHERE langueId=%i AND themeId=%i  AND cible<1 ORDER BY id DESC", $langue , 1);
    $story = $histoire["titre"];
    $storyid = $histoire["id"];
    array_push($data, ["story" => $story, "id" => $storyid]);

    $histoire = DB::queryFirstRow("SELECT * FROM dialogues WHERE langueId=%i AND themeId=%i  AND cible<1 ORDER BY id DESC", $langue , 3);
    $story = $histoire["titre"];
    $storyid = $histoire["id"];
    array_push($data, ["story" => $story, "id" => $storyid]);    

    $data = array("result" => $data);

    header('Content-Type: application/json');
    echo json_encode($data);
?>
