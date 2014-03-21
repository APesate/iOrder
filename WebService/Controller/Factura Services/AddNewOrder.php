<?php
	ini_set("display_errors", 1);

	if (isset($_GET['appKey']) and isset($_GET['user_id'])) {

		include ('../../Model/Factura.php');
		$factura = new Factura();
		
		date_default_timezone_set('America/Caracas');
		$date = date('Y-m-d h:i:s', time());

		$factura->user_id = $_GET['user_id'];
		$factura->creation_date = $date;
		$factura->state = 2;
		
		if($factura->createNewOrder(1)){
			echo '200';
		} else {
			echo '500';
		}
		
	}else {
		echo '0';
	}

?>