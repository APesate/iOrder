<?php
	ini_set("display_errors", 1);

	if (isset($_GET['appKey']) and isset($_GET['product_id'])) {
		include ('Product.php');

		$product = new Product();
		$product->id = $_GET['product_id'];

		if ($product->getProductForId()) {
			echo json_encode($product);
		} else {
			echo '1';
		}
	} else {
		echo '0';
	}

?>