<?php 
	if (isset($_GET['appKey']) AND isset($_GET['orderId']) AND isset($_GET['state'])) {
		include('../../Model/Factura.php');

		$factura = new Factura();
		$factura->id = $_GET['orderId'];
		$factura->state = $_GET['state'];

		if ($factura->changeOrderState()) {
			echo "200";
		} else {
			echo "501";
		}
	}
?>