<html>
<head>
	<?php include "inc_head.php"; ?>
	<?php 
	$histoire  = $_GET["histoire"];

	?>

</head>


<body>
	<?php

	?>

	<?php include "inc_navigation.php"; ?>


	<div class="container">


		<div class="row">

			<?php 
			$dialogue = DB::queryFirstRow("SELECT * FROM dialogues WHERE id=%i" , $histoire );

			$titre         = $dialogue["titre"];   			 
			$chapeau       = $dialogue["chapeau"];
			$ledialogue    = $dialogue["dialogue"];
			$cahierId      = $dialogue['cahierId'];
			$thesaurus     = $dialogue["thesaurus"];
			$ageId         = $dialogue['ageId'];
			$langueId      = $dialogue['langueId'];
			$ordre         = $dialogue['ordre'];
			$id            = $dialogue['id'];
			$title         = $dialogue['title'];
			$description   = $dialogue['description'];
			$keywords      = $dialogue['keywords'];
			$cible         = $dialogue['cible'];
			$illustration  = $dialogue['illustration'];

			?>


			<form role="form" method="POST" action="bd_modi_histoire.php">
				<div class="form-group">
					<label for="titre">Titre:</label>
					<input type="text" class="form-control" id="titre" name="titre" value="<?php echo $titre; ?>">
					<input type="hidden" class="form-control" id="langueId" name="langueId" value="<?php echo $langueId; ?>">
					<input type="hidden" class="form-control" id="id" name="id" value="<?php echo $id; ?>">
					<input type="hidden" class="form-control" id="retour" name="retour" value="<?php echo $_SERVER['HTTP_REFERER']; ?>">





				</div>

				<div class="form-group">
					<label for="chapeau">Chapeau:</label>
					<textarea class="form-control" id="chapeau" name="chapeau"><?php echo $chapeau; ?></textarea>
				</div>

				<div class="form-group">
					<label for="dialogue">Dialogue:</label>
					<textarea style="height:100px;" class="form-control" id="dialogue" name="dialogue"><?php echo $ledialogue; ?></textarea>
				</div>

				<div class="form-group">
					<label for="dialogue">Thesaurus:</label>
					<textarea  class="form-control" id="thesaurus" name="thesaurus"><?php echo $thesaurus; ?></textarea>
				</div>

				<div class="form-group">
					<label for="cahier">Cahier:</label><br />
					<select name="cahierId"  class="form-control">
						<?php 
						$lescahiers = DB::query("SELECT * FROM cahiers");

						print "<option value='0'>-- pas de cahier --</option>";


						foreach( $lescahiers as $lecahier ) {
							print "<option value='" . $lecahier["id"]  . "' ";

							if( $lecahier["id"] == $cahierId ) {
								print "selected";
							}

							print " >" . $lecahier["titre"] . "</option>";
						}
						?>
					</select>
				</div>

				<div class="form-group">
					
					<label for="cahier">Age</label><br />
					<select name="ageId"  class="form-control">
						<?php 
						$lesages = DB::query("SELECT * FROM ages");


						print "<option value='0'>-- pas d'âge --</option>";

						foreach($lesages as $lage) {
							print "<option value='" . $lage["id"]  . "' ";

							if($lage["id"] == $ageId ) {
								print "selected";
							}

							print " >" . $lage["libelle"] . "</option>";
						}

						print "<option value='98'";

						if($ageId == "98" ) {
							print "selected";
						}

						print ">Dialogue demandé</option>";

						print "<option value='99'";

						if($ageId == "99" ) {
							print "selected";
						}

						print ">Dialogues divers</option>";
						print "<option value='100'";

						if($ageId == "100" ) {
							print "selected";
						}
						print ">Dialogues pour les amis</option>";
						?>
					</select>


				</div>


				<div class="form-group">
					<label for="langueId">Langue</label><br />
					<select name="langueId" id="langueId" class="form-control">
						<option value="0" <?php IF ( $langueId == 0 ) { echo "selected"; } ?>>Non publié</option>
						<option value="1" <?php IF ( $langueId == 1 ) { echo "selected"; } ?>>Français</option>
						<option value="2" <?php IF ( $langueId == 2 ) { echo "selected"; } ?>>Allemand</option>
						<option value="3" <?php IF ( $langueId == 3 ) { echo "selected"; } ?>>Anglais</option>
					</select>


				</div>

				<div class="form-group">
					<label for="ordre">Ordre</label>
					<input type="text" class="form-control" id="ordre" name="ordre" value="<?php echo $ordre; ?>">
				</div>


					<div class="form-group">
					<label for="ordre">Illustration</label>
					<input type="text" class="form-control" id="illustration" name="illustration" value="<?php echo $illustration; ?>">
				</div>

				<hr />

				<div class="form-group">
					<label for="title">META Titre</label>
					<input type="text" class="form-control" id="title" name="title" value="<?php echo $title; ?>">
				</div>

				<div class="form-group">
					<label for="title">META Keywords</label>
					<input type="text" class="form-control" id="keywords" name="keywords" value="<?php echo $keywords; ?>">
				</div>


				<div class="form-group">
					<label for="title">META Description</label>
					<textarea class="form-control" id="description" name="description"><?php echo $description; ?></textarea>
				</div>

				<div class="form-group">
					<label for="title">Public-cible (0 = tous; 1 = éveillé)</label>
					<input type="text" class="form-control" id="cible" name="cible" value="<?php echo $cible; ?>">
				</div>


				<button type="submit" class="btn btn-default">Submit</button>
			</form>

		</div>


	</div>


</div>
</body>
</html>