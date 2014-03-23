<?php
	ini_set("display_errors", 1);

	if (isset($_GET['appKey']) and isset($_GET['categorie_id'])) {
		include ('../../Model/Categorie.php');

		$categorie = new Categorie();
		$categorie->id = $_GET['categorie_id'];

		if ($categorie->getAllProductForCategorie()){
			echo json_encode($categorie->products);
		} else {
			echo '0';
		}
	} else {
		echo '0';
	}
?>