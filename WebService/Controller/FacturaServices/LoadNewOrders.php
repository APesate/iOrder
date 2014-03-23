<?php
	if(isset($_GET['appKey'])){
		include('../../Model/Factura.php');

		$factura = new Factura();

		if ($factura->loadNewOrders()) {
			echo '200';
		} else {
			echo '501';
		}
	} else {
		echo '0';
	}
?>