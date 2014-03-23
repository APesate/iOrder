<?php
	ini_set("display_errors", 1);

	if (isset($_GET['appKey'])) {

		include ('../../Model/Categorie.php');
		$categorie = new Categorie();

		echo json_encode($categorie->getAllCategories());
	}else {
		echo '0';
	}

?>