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
    $dialogues = DB::query("SELECT dialogues.titre, dialogues.chapeau, dialogues.id as did FROM dialogues left JOIN ages ON ( ages.id = dialogues.ageId ) WHERE   dialogues.ageId=%i  AND dialogues.langueId=%i  ORDER BY dialogues.id DESC ", 5, $langue);
    array_push($data, $dialogues);

    $dialogues = DB::query("SELECT dialogues.titre, dialogues.chapeau, dialogues.id as did FROM dialogues left JOIN ages ON ( ages.id = dialogues.ageId ) WHERE   dialogues.ageId=%i  AND dialogues.langueId=%i  ORDER BY dialogues.id DESC ", 4, $langue);
    array_push($data, $dialogues);

    $dialogues = DB::query("SELECT dialogues.titre, dialogues.chapeau, dialogues.id as did FROM dialogues left JOIN ages ON ( ages.id = dialogues.ageId ) WHERE   dialogues.ageId=%i  AND dialogues.langueId=%i  ORDER BY dialogues.id DESC ", 3, $langue);
    array_push($data, $dialogues);

    $dialogues = DB::query("SELECT dialogues.titre, dialogues.chapeau, dialogues.id as did FROM dialogues left JOIN ages ON ( ages.id = dialogues.ageId ) WHERE   dialogues.ageId=%i  AND dialogues.langueId=%i  ORDER BY dialogues.id DESC ", 2, $langue);
    array_push($data, $dialogues);

    $dialogues = DB::query("SELECT dialogues.titre, dialogues.chapeau, dialogues.id as did FROM dialogues left JOIN ages ON ( ages.id = dialogues.ageId ) WHERE   dialogues.ageId=%i  AND dialogues.langueId=%i  ORDER BY dialogues.id DESC ", 1, $langue);
    array_push($data, $dialogues);

    $data = array("result" => $data);

    header('Content-Type: application/json');
    echo json_encode($data);
?>
