<?php
	ini_set("display_errors", 1);

	if (isset($_GET['appKey']) and isset($_GET['deviceToken'])) {

		include ('../../Model/Factura.php');
		$factura = new Factura();
		
		date_default_timezone_set('America/Caracas');
		$date = date('Y-m-d h:i:s', time());

		$factura->creation_date = $date;
		$factura->state = 2;
		$factura->deviceToken = $_GET['deviceToken'];
		
		if($factura->createNewOrder()){
			echo '200';
		} else {
			echo '500';
		}
		
	}else {
		echo '0';
	}

?>